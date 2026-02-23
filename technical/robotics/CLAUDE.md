# Robotics & Simulation — CLAUDE.md
# Version 1.1 | Cookbook-SME-Robotics

---

## 1. Role & Context

You are assisting the **Robotics and Simulation team** at a 100-person robotics and web development SME.

**Team size:** ~15 engineers (senior technical)  
**Core domain:** ROS2 (Robot Operating System 2), Python (rclpy), Gazebo/Webots simulation  
**Build system:** colcon | **ROS distro:** Humble Hawksbill | **OS:** Ubuntu 22.04

We build autonomous robot navigation systems, manipulation pipelines, and simulation environments. Our biggest bottleneck is converting design diagrams and whiteboard mockups into working ROS2 boilerplate fast enough to iterate during design sprints.

---

## 2. Audience Instructions

- Assume **expert-level Python, ROS2, and Linux fluency** for all technical staff.
- Code must be **production-ready from the first draft**: full docstrings, type hints, try-except blocks, structured logging via `rclpy.logging`.
- Follow ROS2 naming conventions: `snake_case` for nodes and topics, `PascalCase` for classes, `ALL_CAPS` for constants.
- Never use `rospy` (ROS1). Only `rclpy` (ROS2).
- Always specify the full topic type (e.g., `sensor_msgs/msg/LaserScan`) — never abbreviate.

---

## 3. Tools & Environment

| Tool | Purpose | Notes |
|---|---|---|
| `rclpy` | Python ROS2 client library | Import as `import rclpy` |
| `colcon` | Build system | See build commands below |
| `ros2 launch` | Launching nodes | Use Python launch files, not XML |
| Gazebo Classic | Primary simulator | Use `gazebo_ros` for ROS2 integration |
| Webots | Alternative simulator | Use `webots_ros2` package |
| `ros2 topic echo` | Debug pub/sub | Use for verifying message flow |

**Workspace paths:**
- ROS2 workspace root: `~/ros2_ws/`
- Source packages: `~/ros2_ws/src/`
- Built packages: `~/ros2_ws/install/`

**Standard build sequence:**
```bash
cd ~/ros2_ws
colcon build --symlink-install
source install/setup.bash
```

**Standard test sequence:**
```bash
cd ~/ros2_ws
colcon test --packages-select [PACKAGE_NAME]
colcon test-result --verbose
```

**MCP Boundaries:**
- ✅ Allowed: Read local files, write Python files, execute colcon commands
- ❌ Forbidden: Deploy to physical robot hardware without human sign-off
- ❌ Forbidden: Modify active production robot configs without git checkpoint

---

## 4. Primary Workflows

### Workflow A: Image/Mockup → ROS2 Node

**When to use:** Any time a whiteboard diagram or system block diagram needs to become code.

```
Step 1: Read sample_mockup.txt (or pasted image). Extract:
   - Node names
   - Topic names and message types
   - Subscribe/publish relationships
   - Business logic (conditions, thresholds, actions)
Step 2: Generate a complete ROS2 Python node using the canonical structure (see Section 6)
Step 3: Generate a Python launch file for the node
Step 4: Generate a minimal package.xml and setup.py
Step 5: Run static analysis: describe what to verify before building
Step 6: Output all files to a named directory: [node_name]_ws/
Step 7: Include colcon build commands as a code block
Step 8: git commit -m "feat: [node_name] generated from mockup"
```

### Workflow B: Test Generation for Existing Node

**When to use:** After implementing a node, to ensure correctness.

```
Step 1: Read the target Python node file
Step 2: Identify all public methods and callback functions
Step 3: Generate pytest-compatible unit tests covering:
   - Happy path for all callbacks
   - Edge cases (empty messages, out-of-range values, None inputs)
   - Error handling paths
Step 4: Place tests in [PACKAGE_NAME]/test/test_[node_name].py
Step 5: Run: colcon test --packages-select [PACKAGE_NAME]
```

### Workflow C: Codebase Comprehension

**When to use:** When a new team member or rotating engineer needs to understand an existing package.

```
Step 1: Ask for the package name or path
Step 2: Trace the node graph: which nodes publish/subscribe to which topics
Step 3: Identify all external dependencies (message types, services, action servers)
Step 4: Produce a plain-English summary + a Mermaid diagram of the node graph
Step 5: Flag any potential issues: race conditions, missing QoS settings, unbounded queues
```

---

## 5. Sub-Agent Architecture

For complex multi-node systems, spawn specialized agents:

| Agent | Responsibility | Input | Output |
|---|---|---|---|
| **Parser Agent** | Extract node/topic graph from mockup | Image or text description | Structured node graph JSON |
| **Node Builder Agent** | Generate one Python node per node in graph | Node spec from parser | Complete `.py` file |
| **Launch Builder Agent** | Generate launch file | All node specs | `.launch.py` file |
| **Test Agent** | Generate unit tests | Each `.py` node file | `test_*.py` files |
| **Validator Agent** | Static analysis + colcon dry-run check | All generated files | Pass/fail report |

---

## 6. Canonical ROS2 Node Structure

Every generated node must follow this structure:

```python
#!/usr/bin/env python3
"""
Node Name: [node_name]
Purpose: [one sentence]
Subscribes: [topic_name] ([MessageType])
Publishes: [topic_name] ([MessageType])
"""
import rclpy
from rclpy.node import Node
from [msg_package].msg import [MessageType]

class [NodeNamePascalCase](Node):
    """[Class docstring explaining the node's purpose]."""

    def __init__(self):
        super().__init__('[node_name]')
        self.declare_parameter('[param_name]', [default_value])
        self._[param] = self.get_parameter('[param_name]').value
        self._subscription = self.create_subscription(
            [MessageType], '[topic]', self._callback, 10)
        self._publisher = self.create_publisher(
            [OutputType], '[output_topic]', 10)
        self.get_logger().info('[NodeName] initialized')

    def _callback(self, msg: [MessageType]) -> None:
        """Process incoming [topic] message."""
        try:
            # Business logic here
            pass
        except Exception as e:
            self.get_logger().error(f'Callback error: {e}')

def main(args=None):
    rclpy.init(args=args)
    node = [NodeNamePascalCase]()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        pass
    finally:
        node.destroy_node()
        rclpy.shutdown()

if __name__ == '__main__':
    main()
```

---

## 7. Common ROS2 Message Types Quick Reference

| Sensor Data | Type |
|---|---|
| Lidar scan | `sensor_msgs/msg/LaserScan` |
| Camera image | `sensor_msgs/msg/Image` |
| IMU | `sensor_msgs/msg/Imu` |
| Odometry | `nav_msgs/msg/Odometry` |

| Commands & Control | Type |
|---|---|
| Velocity command | `geometry_msgs/msg/Twist` |
| Pose target | `geometry_msgs/msg/PoseStamped` |
| Joint states | `sensor_msgs/msg/JointState` |

---

## 8. Safety & Forbidden Actions

1. **Git checkpoint first.** `git add -A && git commit -m "checkpoint"` before any autonomous code generation.
2. **Run `/security-review` on all PRs** before merge.
3. **Never modify active packages** in `~/ros2_ws/src/` without a git checkpoint.
4. **Do not deploy** generated code to a physical robot without human review and sign-off.
5. **Always specify QoS settings** explicitly — never rely on defaults for safety-critical topics.
6. **Test in simulation first** — always validate in Gazebo before physical deployment.

---

## 9. Custom Slash Commands

| Command | What it does |
|---|---|
| `/generate-node [mockup_file]` | Run Workflow A end-to-end |
| `/generate-tests [node_file]` | Run Workflow B for a specific node |
| `/explain-package [package_name]` | Run Workflow C for codebase comprehension |
| `/security-review` | Run security checklist (see `cross-team/security-review/`) |

---

## 10. Session-End Ritual

At the end of every session, ask Claude:
> *"Summarize what we did and suggest 3 improvements to this CLAUDE.md."*

Then:
1. Add suggestions to `## Lessons Learned` below.
2. Log to root `CHANGELOG.md`: `YYYY-MM-DD | Robotics | [What changed]`
3. `git commit -m "session-end: robotics [brief]"`

---

## Lessons Learned

| Date | Lesson | Added By |
|---|---|---|
| 2026-02-23 | Added colcon build sequence, canonical node template, message type reference, sub-agent architecture, and simulation-first safety rule | Setup |
