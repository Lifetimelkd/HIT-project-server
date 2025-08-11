/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 80039
Source Host           : localhost:3306
Source Database       : hit_project

Target Server Type    : MYSQL
Target Server Version : 80039
File Encoding         : 65001

Date: 2025-08-11 17:46:41
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for flow_category
-- ----------------------------
DROP TABLE IF EXISTS `flow_category`;
CREATE TABLE `flow_category` (
  `category_id` bigint NOT NULL COMMENT '流程分类ID',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `parent_id` bigint DEFAULT '0' COMMENT '父流程分类id',
  `ancestors` varchar(500) DEFAULT '' COMMENT '祖级列表',
  `category_name` varchar(30) NOT NULL COMMENT '流程分类名称',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='流程分类';

-- ----------------------------
-- Records of flow_category
-- ----------------------------
INSERT INTO `flow_category` VALUES ('100', '000000', '0', '0', 'OA审批', '0', '0', '103', '1', '2025-08-08 13:50:02', null, null);
INSERT INTO `flow_category` VALUES ('101', '000000', '100', '0,100', '假勤管理', '0', '0', '103', '1', '2025-08-08 13:50:02', null, null);
INSERT INTO `flow_category` VALUES ('102', '000000', '100', '0,100', '人事管理', '1', '0', '103', '1', '2025-08-08 13:50:02', null, null);
INSERT INTO `flow_category` VALUES ('103', '000000', '101', '0,100,101', '请假', '0', '0', '103', '1', '2025-08-08 13:50:02', null, null);
INSERT INTO `flow_category` VALUES ('104', '000000', '101', '0,100,101', '出差', '1', '0', '103', '1', '2025-08-08 13:50:02', null, null);
INSERT INTO `flow_category` VALUES ('105', '000000', '101', '0,100,101', '加班', '2', '0', '103', '1', '2025-08-08 13:50:02', null, null);
INSERT INTO `flow_category` VALUES ('106', '000000', '101', '0,100,101', '换班', '3', '0', '103', '1', '2025-08-08 13:50:02', null, null);
INSERT INTO `flow_category` VALUES ('107', '000000', '101', '0,100,101', '外出', '4', '0', '103', '1', '2025-08-08 13:50:02', null, null);
INSERT INTO `flow_category` VALUES ('108', '000000', '102', '0,100,102', '转正', '1', '0', '103', '1', '2025-08-08 13:50:02', null, null);
INSERT INTO `flow_category` VALUES ('109', '000000', '102', '0,100,102', '离职', '2', '0', '103', '1', '2025-08-08 13:50:02', null, null);

-- ----------------------------
-- Table structure for flow_definition
-- ----------------------------
DROP TABLE IF EXISTS `flow_definition`;
CREATE TABLE `flow_definition` (
  `id` bigint NOT NULL COMMENT '主键id',
  `flow_code` varchar(40) NOT NULL COMMENT '流程编码',
  `flow_name` varchar(100) NOT NULL COMMENT '流程名称',
  `category` varchar(100) DEFAULT NULL COMMENT '流程类别',
  `version` varchar(20) NOT NULL COMMENT '流程版本',
  `is_publish` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否发布（0未发布 1已发布 9失效）',
  `form_custom` char(1) DEFAULT 'N' COMMENT '审批表单是否自定义（Y是 N否）',
  `form_path` varchar(100) DEFAULT NULL COMMENT '审批表单路径',
  `activity_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '流程激活状态（0挂起 1激活）',
  `listener_type` varchar(100) DEFAULT NULL COMMENT '监听器类型',
  `listener_path` varchar(400) DEFAULT NULL COMMENT '监听器路径',
  `ext` varchar(500) DEFAULT NULL COMMENT '业务详情 存业务表对象json字符串',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志',
  `tenant_id` varchar(40) DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='流程定义表';

-- ----------------------------
-- Records of flow_definition
-- ----------------------------

-- ----------------------------
-- Table structure for flow_his_task
-- ----------------------------
DROP TABLE IF EXISTS `flow_his_task`;
CREATE TABLE `flow_his_task` (
  `id` bigint NOT NULL COMMENT '主键id',
  `definition_id` bigint NOT NULL COMMENT '对应flow_definition表的id',
  `instance_id` bigint NOT NULL COMMENT '对应flow_instance表的id',
  `task_id` bigint NOT NULL COMMENT '对应flow_task表的id',
  `node_code` varchar(100) DEFAULT NULL COMMENT '开始节点编码',
  `node_name` varchar(100) DEFAULT NULL COMMENT '开始节点名称',
  `node_type` tinyint(1) DEFAULT NULL COMMENT '开始节点类型（0开始节点 1中间节点 2结束节点 3互斥网关 4并行网关）',
  `target_node_code` varchar(200) DEFAULT NULL COMMENT '目标节点编码',
  `target_node_name` varchar(200) DEFAULT NULL COMMENT '结束节点名称',
  `approver` varchar(40) DEFAULT NULL COMMENT '审批者',
  `cooperate_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '协作方式(1审批 2转办 3委派 4会签 5票签 6加签 7减签)',
  `collaborator` varchar(40) DEFAULT NULL COMMENT '协作人',
  `skip_type` varchar(10) NOT NULL COMMENT '流转类型（PASS通过 REJECT退回 NONE无动作）',
  `flow_status` varchar(20) NOT NULL COMMENT '流程状态（0待提交 1审批中 2审批通过 4终止 5作废 6撤销 8已完成 9已退回 10失效 11拿回）',
  `form_custom` char(1) DEFAULT 'N' COMMENT '审批表单是否自定义（Y是 N否）',
  `form_path` varchar(100) DEFAULT NULL COMMENT '审批表单路径',
  `message` varchar(500) DEFAULT NULL COMMENT '审批意见',
  `variable` text COMMENT '任务变量',
  `ext` text COMMENT '业务详情 存业务表对象json字符串',
  `create_time` datetime DEFAULT NULL COMMENT '任务开始时间',
  `update_time` datetime DEFAULT NULL COMMENT '审批完成时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志',
  `tenant_id` varchar(40) DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='历史任务记录表';

-- ----------------------------
-- Records of flow_his_task
-- ----------------------------

-- ----------------------------
-- Table structure for flow_instance
-- ----------------------------
DROP TABLE IF EXISTS `flow_instance`;
CREATE TABLE `flow_instance` (
  `id` bigint NOT NULL COMMENT '主键id',
  `definition_id` bigint NOT NULL COMMENT '对应flow_definition表的id',
  `business_id` varchar(40) NOT NULL COMMENT '业务id',
  `node_type` tinyint(1) NOT NULL COMMENT '节点类型（0开始节点 1中间节点 2结束节点 3互斥网关 4并行网关）',
  `node_code` varchar(40) NOT NULL COMMENT '流程节点编码',
  `node_name` varchar(100) DEFAULT NULL COMMENT '流程节点名称',
  `variable` text COMMENT '任务变量',
  `flow_status` varchar(20) NOT NULL COMMENT '流程状态（0待提交 1审批中 2审批通过 4终止 5作废 6撤销 8已完成 9已退回 10失效 11拿回）',
  `activity_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '流程激活状态（0挂起 1激活）',
  `def_json` text COMMENT '流程定义json',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `ext` varchar(500) DEFAULT NULL COMMENT '扩展字段，预留给业务系统使用',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志',
  `tenant_id` varchar(40) DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='流程实例表';

-- ----------------------------
-- Records of flow_instance
-- ----------------------------

-- ----------------------------
-- Table structure for flow_node
-- ----------------------------
DROP TABLE IF EXISTS `flow_node`;
CREATE TABLE `flow_node` (
  `id` bigint NOT NULL COMMENT '主键id',
  `node_type` tinyint(1) NOT NULL COMMENT '节点类型（0开始节点 1中间节点 2结束节点 3互斥网关 4并行网关）',
  `definition_id` bigint NOT NULL COMMENT '流程定义id',
  `node_code` varchar(100) NOT NULL COMMENT '流程节点编码',
  `node_name` varchar(100) DEFAULT NULL COMMENT '流程节点名称',
  `permission_flag` varchar(200) DEFAULT NULL COMMENT '权限标识（权限类型:权限标识，可以多个，用@@隔开)',
  `node_ratio` decimal(6,3) DEFAULT NULL COMMENT '流程签署比例值',
  `coordinate` varchar(100) DEFAULT NULL COMMENT '坐标',
  `any_node_skip` varchar(100) DEFAULT NULL COMMENT '任意结点跳转',
  `listener_type` varchar(100) DEFAULT NULL COMMENT '监听器类型',
  `listener_path` varchar(400) DEFAULT NULL COMMENT '监听器路径',
  `handler_type` varchar(100) DEFAULT NULL COMMENT '处理器类型',
  `handler_path` varchar(400) DEFAULT NULL COMMENT '处理器路径',
  `form_custom` char(1) DEFAULT 'N' COMMENT '审批表单是否自定义（Y是 N否）',
  `form_path` varchar(100) DEFAULT NULL COMMENT '审批表单路径',
  `version` varchar(20) NOT NULL COMMENT '版本',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `ext` text COMMENT '节点扩展属性',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志',
  `tenant_id` varchar(40) DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='流程节点表';

-- ----------------------------
-- Records of flow_node
-- ----------------------------

-- ----------------------------
-- Table structure for flow_skip
-- ----------------------------
DROP TABLE IF EXISTS `flow_skip`;
CREATE TABLE `flow_skip` (
  `id` bigint NOT NULL COMMENT '主键id',
  `definition_id` bigint NOT NULL COMMENT '流程定义id',
  `now_node_code` varchar(100) NOT NULL COMMENT '当前流程节点的编码',
  `now_node_type` tinyint(1) DEFAULT NULL COMMENT '当前节点类型（0开始节点 1中间节点 2结束节点 3互斥网关 4并行网关）',
  `next_node_code` varchar(100) NOT NULL COMMENT '下一个流程节点的编码',
  `next_node_type` tinyint(1) DEFAULT NULL COMMENT '下一个节点类型（0开始节点 1中间节点 2结束节点 3互斥网关 4并行网关）',
  `skip_name` varchar(100) DEFAULT NULL COMMENT '跳转名称',
  `skip_type` varchar(40) DEFAULT NULL COMMENT '跳转类型（PASS审批通过 REJECT退回）',
  `skip_condition` varchar(200) DEFAULT NULL COMMENT '跳转条件',
  `coordinate` varchar(100) DEFAULT NULL COMMENT '坐标',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志',
  `tenant_id` varchar(40) DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='节点跳转关联表';

-- ----------------------------
-- Records of flow_skip
-- ----------------------------

-- ----------------------------
-- Table structure for flow_task
-- ----------------------------
DROP TABLE IF EXISTS `flow_task`;
CREATE TABLE `flow_task` (
  `id` bigint NOT NULL COMMENT '主键id',
  `definition_id` bigint NOT NULL COMMENT '对应flow_definition表的id',
  `instance_id` bigint NOT NULL COMMENT '对应flow_instance表的id',
  `node_code` varchar(100) NOT NULL COMMENT '节点编码',
  `node_name` varchar(100) DEFAULT NULL COMMENT '节点名称',
  `node_type` tinyint(1) NOT NULL COMMENT '节点类型（0开始节点 1中间节点 2结束节点 3互斥网关 4并行网关）',
  `flow_status` varchar(20) NOT NULL COMMENT '流程状态（0待提交 1审批中 2审批通过 4终止 5作废 6撤销 8已完成 9已退回 10失效 11拿回）',
  `form_custom` char(1) DEFAULT 'N' COMMENT '审批表单是否自定义（Y是 N否）',
  `form_path` varchar(100) DEFAULT NULL COMMENT '审批表单路径',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志',
  `tenant_id` varchar(40) DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='待办任务表';

-- ----------------------------
-- Records of flow_task
-- ----------------------------

-- ----------------------------
-- Table structure for flow_user
-- ----------------------------
DROP TABLE IF EXISTS `flow_user`;
CREATE TABLE `flow_user` (
  `id` bigint NOT NULL COMMENT '主键id',
  `type` char(1) NOT NULL COMMENT '人员类型（1待办任务的审批人权限 2待办任务的转办人权限 3待办任务的委托人权限）',
  `processed_by` varchar(80) DEFAULT NULL COMMENT '权限人',
  `associated` bigint NOT NULL COMMENT '任务表id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(80) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志',
  `tenant_id` varchar(40) DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_processed_type` (`processed_by`,`type`),
  KEY `user_associated` (`associated`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='流程用户表';

-- ----------------------------
-- Records of flow_user
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table` (
  `table_id` bigint NOT NULL COMMENT '编号',
  `data_name` varchar(200) DEFAULT '' COMMENT '数据源名称',
  `table_name` varchar(200) DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) DEFAULT NULL COMMENT '其它生成选项',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='代码生成业务表';

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES ('1954824876720672770', 'master', 'hit_user_profile', '用户扩展档案表', null, null, 'HitUserProfile', 'crud', 'org.dromara.hit', 'hitUserProfile', 'userProfile', '用户扩展档案', 'LKD', '0', '/', '{\"treeCode\":null,\"treeName\":null,\"treeParentCode\":null,\"parentMenuId\":null}', '103', '1', '2025-08-11 16:39:04', '1', '2025-08-11 16:41:25', null);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column` (
  `column_id` bigint NOT NULL COMMENT '编号',
  `table_id` bigint DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) DEFAULT '' COMMENT '字典类型',
  `sort` int DEFAULT NULL COMMENT '排序',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='代码生成业务表字段';

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES ('1954824877119131650', '1954824876720672770', 'profile_id', '用户档案ID', 'bigint', 'Long', 'profileId', '1', '1', '0', null, '1', '1', null, 'EQ', 'input', '', '1', '103', '1', '2025-08-11 16:39:04', '1', '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` VALUES ('1954824877177851905', '1954824876720672770', 'user_id', '关联用户id', 'bigint', 'Long', 'userId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', '2', '103', '1', '2025-08-11 16:39:04', '1', '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` VALUES ('1954824877177851906', '1954824876720672770', 'student_id', '学号', 'varchar(20)', 'String', 'studentId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '3', '103', '1', '2025-08-11 16:39:04', '1', '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` VALUES ('1954824877177851907', '1954824876720672770', 'real_name', '真实姓名', 'varchar(50)', 'String', 'realName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', '4', '103', '1', '2025-08-11 16:39:04', '1', '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` VALUES ('1954824877177851908', '1954824876720672770', 'college', '所属学院', 'varchar(100)', 'String', 'college', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'hit_college', '5', '103', '1', '2025-08-11 16:39:04', '1', '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` VALUES ('1954824877177851909', '1954824876720672770', 'major', '专业', 'varchar(100)', 'String', 'major', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '6', '103', '1', '2025-08-11 16:39:04', '1', '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` VALUES ('1954824877177851910', '1954824876720672770', 'grade', '年级', 'varchar(20)', 'String', 'grade', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'hit_grade', '7', '103', '1', '2025-08-11 16:39:04', '1', '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` VALUES ('1954824877177851911', '1954824876720672770', 'class_name', '班级', 'varchar(50)', 'String', 'className', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', '8', '103', '1', '2025-08-11 16:39:04', '1', '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` VALUES ('1954824877177851912', '1954824876720672770', 'phone', '手机号', 'varchar(20)', 'String', 'phone', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '9', '103', '1', '2025-08-11 16:39:04', '1', '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` VALUES ('1954824877177851913', '1954824876720672770', 'email', '邮箱', 'varchar(100)', 'String', 'email', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '10', '103', '1', '2025-08-11 16:39:04', '1', '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` VALUES ('1954824877177851914', '1954824876720672770', 'qq', 'QQ号', 'varchar(20)', 'String', 'qq', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '11', '103', '1', '2025-08-11 16:39:04', '1', '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` VALUES ('1954824877177851915', '1954824876720672770', 'wechat', '微信号', 'varchar(50)', 'String', 'wechat', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '12', '103', '1', '2025-08-11 16:39:04', '1', '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` VALUES ('1954824877177851916', '1954824876720672770', 'github', 'GitHub地址', 'varchar(100)', 'String', 'github', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '13', '103', '1', '2025-08-11 16:39:04', '1', '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` VALUES ('1954824877177851917', '1954824876720672770', 'linkedin', 'LinkedIn地址', 'varchar(100)', 'String', 'linkedin', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '14', '103', '1', '2025-08-11 16:39:04', '1', '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` VALUES ('1954824877177851918', '1954824876720672770', 'personal_intro', '个人简介', 'text', 'String', 'personalIntro', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'textarea', '', '15', '103', '1', '2025-08-11 16:39:04', '1', '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` VALUES ('1954824877177851919', '1954824876720672770', 'career_plan', '职业规划', 'text', 'String', 'careerPlan', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'textarea', '', '16', '103', '1', '2025-08-11 16:39:04', '1', '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` VALUES ('1954824877177851920', '1954824876720672770', 'avatar_url', '头像地址', 'varchar(500)', 'String', 'avatarUrl', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'textarea', '', '17', '103', '1', '2025-08-11 16:39:04', '1', '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` VALUES ('1954824877177851921', '1954824876720672770', 'cover_url', '封面地址', 'varchar(500)', 'String', 'coverUrl', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'textarea', '', '18', '103', '1', '2025-08-11 16:39:04', '1', '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` VALUES ('1954824877240766466', '1954824876720672770', 'reputation_score', '信誉积分', 'decimal(5,2)', 'Long', 'reputationScore', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '19', '103', '1', '2025-08-11 16:39:04', '1', '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` VALUES ('1954824877240766467', '1954824876720672770', 'total_projects', '参与项目总数', 'int', 'Long', 'totalProjects', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '20', '103', '1', '2025-08-11 16:39:04', '1', '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` VALUES ('1954824877240766468', '1954824876720672770', 'completed_projects', '完成项目数', 'int', 'Long', 'completedProjects', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '21', '103', '1', '2025-08-11 16:39:04', '1', '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` VALUES ('1954824877240766469', '1954824876720672770', 'status', '状态(0正常 1禁用)', 'char(1)', 'String', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', '22', '103', '1', '2025-08-11 16:39:04', '1', '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` VALUES ('1954824877240766470', '1954824876720672770', 'tenant_id', '租户ID', 'varchar(20)', 'String', 'tenantId', '0', '0', '1', null, null, null, null, 'EQ', 'input', '', '23', '103', '1', '2025-08-11 16:39:04', '1', '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` VALUES ('1954824877240766471', '1954824876720672770', 'create_dept', '创建部门', 'bigint', 'Long', 'createDept', '0', '0', '1', null, null, null, null, 'EQ', 'input', '', '24', '103', '1', '2025-08-11 16:39:04', '1', '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` VALUES ('1954824877240766472', '1954824876720672770', 'create_by', '创建者', 'bigint', 'Long', 'createBy', '0', '0', '1', null, null, null, null, 'EQ', 'input', '', '25', '103', '1', '2025-08-11 16:39:04', '1', '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` VALUES ('1954824877240766473', '1954824876720672770', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '1', null, null, null, null, 'EQ', 'datetime', '', '26', '103', '1', '2025-08-11 16:39:04', '1', '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` VALUES ('1954824877240766474', '1954824876720672770', 'update_by', '更新者', 'bigint', 'Long', 'updateBy', '0', '0', '1', null, null, null, null, 'EQ', 'input', '', '27', '103', '1', '2025-08-11 16:39:04', '1', '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` VALUES ('1954824877240766475', '1954824876720672770', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '1', null, null, null, null, 'EQ', 'datetime', '', '28', '103', '1', '2025-08-11 16:39:04', '1', '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` VALUES ('1954824877240766476', '1954824876720672770', 'dept_id', '关联部门id', 'bigint', 'Long', 'deptId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '29', '103', '1', '2025-08-11 16:39:04', '1', '2025-08-11 16:41:25');

-- ----------------------------
-- Table structure for hit_mentor
-- ----------------------------
DROP TABLE IF EXISTS `hit_mentor`;
CREATE TABLE `hit_mentor` (
  `mentor_id` bigint NOT NULL AUTO_INCREMENT COMMENT '导师ID',
  `user_id` bigint NOT NULL COMMENT '关联用户ID',
  `employee_id` varchar(50) DEFAULT NULL COMMENT '工号',
  `title` varchar(50) DEFAULT NULL COMMENT '职称',
  `college` varchar(100) DEFAULT NULL COMMENT '所属学院',
  `department` varchar(100) DEFAULT NULL COMMENT '所属系部',
  `research_areas` text COMMENT '研究方向',
  `expertise_keywords` text COMMENT '专业关键词(JSON格式)',
  `office_location` varchar(200) DEFAULT NULL COMMENT '办公室地址',
  `office_hours` varchar(200) DEFAULT NULL COMMENT '接待时间',
  `contact_email` varchar(100) DEFAULT NULL COMMENT '联系邮箱',
  `contact_phone` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `academic_homepage` varchar(500) DEFAULT NULL COMMENT '学术主页',
  `introduction` text COMMENT '个人介绍',
  `achievements` text COMMENT '主要成就',
  `current_projects` int DEFAULT '0' COMMENT '当前指导项目数',
  `total_projects` int DEFAULT '0' COMMENT '历史指导项目数',
  `student_rating` decimal(3,2) DEFAULT '0.00' COMMENT '学生评分',
  `rating_count` int DEFAULT '0' COMMENT '评分人数',
  `is_accepting` char(1) DEFAULT '1' COMMENT '是否接受新项目(0否 1是)',
  `max_projects` int DEFAULT '10' COMMENT '最大指导项目数',
  `status` char(1) DEFAULT '0' COMMENT '状态(0正常 1禁用)',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户ID',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `dept_id` bigint DEFAULT NULL COMMENT '关联部门id',
  PRIMARY KEY (`mentor_id`),
  UNIQUE KEY `uk_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='导师信息表';

-- ----------------------------
-- Records of hit_mentor
-- ----------------------------

-- ----------------------------
-- Table structure for hit_mentor_rating
-- ----------------------------
DROP TABLE IF EXISTS `hit_mentor_rating`;
CREATE TABLE `hit_mentor_rating` (
  `rating_id` bigint NOT NULL AUTO_INCREMENT COMMENT '评价ID',
  `mentor_id` bigint NOT NULL COMMENT '导师ID',
  `user_id` bigint NOT NULL COMMENT '评价人ID',
  `project_id` bigint DEFAULT NULL COMMENT '相关项目ID',
  `professional_score` tinyint DEFAULT '5' COMMENT '专业能力评分(1-5)',
  `guidance_score` tinyint DEFAULT '5' COMMENT '指导能力评分(1-5)',
  `communication_score` tinyint DEFAULT '5' COMMENT '沟通能力评分(1-5)',
  `responsibility_score` tinyint DEFAULT '5' COMMENT '责任心评分(1-5)',
  `overall_score` decimal(3,2) DEFAULT '5.00' COMMENT '综合评分',
  `comment` text COMMENT '评价内容',
  `is_anonymous` char(1) DEFAULT '0' COMMENT '是否匿名(0否 1是)',
  `is_public` char(1) DEFAULT '1' COMMENT '是否公开(0否 1是)',
  `helpful_count` int DEFAULT '0' COMMENT '有用数',
  `status` char(1) DEFAULT '0' COMMENT '状态(0正常 1隐藏)',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户ID',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `dept_id` bigint DEFAULT NULL COMMENT '关联部门id',
  PRIMARY KEY (`rating_id`),
  KEY `idx_mentor` (`mentor_id`),
  KEY `idx_user` (`user_id`),
  KEY `idx_project` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='导师评价表';

-- ----------------------------
-- Records of hit_mentor_rating
-- ----------------------------

-- ----------------------------
-- Table structure for hit_notification
-- ----------------------------
DROP TABLE IF EXISTS `hit_notification`;
CREATE TABLE `hit_notification` (
  `notification_id` bigint NOT NULL AUTO_INCREMENT COMMENT '通知ID',
  `user_id` bigint NOT NULL COMMENT '接收用户ID',
  `sender_id` bigint DEFAULT NULL COMMENT '发送者ID',
  `notification_type` varchar(50) NOT NULL COMMENT '通知类型(application/approval/project_update/task_assign等)',
  `title` varchar(200) NOT NULL COMMENT '通知标题',
  `content` text COMMENT '通知内容',
  `related_id` bigint DEFAULT NULL COMMENT '相关对象ID(项目ID/任务ID等)',
  `related_type` varchar(50) DEFAULT NULL COMMENT '相关对象类型(project/task/application等)',
  `action_url` varchar(500) DEFAULT NULL COMMENT '操作链接',
  `is_read` char(1) DEFAULT '0' COMMENT '是否已读(0否 1是)',
  `read_time` datetime DEFAULT NULL COMMENT '阅读时间',
  `priority` varchar(20) DEFAULT 'normal' COMMENT '优先级(low/normal/high/urgent)',
  `channel` varchar(50) DEFAULT 'system' COMMENT '通知渠道(system/email/sms/wechat)',
  `send_status` varchar(20) DEFAULT 'pending' COMMENT '发送状态(pending/sent/failed)',
  `send_time` datetime DEFAULT NULL COMMENT '发送时间',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户ID',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `dept_id` bigint DEFAULT NULL COMMENT '关联部门id',
  PRIMARY KEY (`notification_id`),
  KEY `idx_user` (`user_id`),
  KEY `idx_type` (`notification_type`),
  KEY `idx_related` (`related_id`,`related_type`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='消息通知表';

-- ----------------------------
-- Records of hit_notification
-- ----------------------------

-- ----------------------------
-- Table structure for hit_platform_config
-- ----------------------------
DROP TABLE IF EXISTS `hit_platform_config`;
CREATE TABLE `hit_platform_config` (
  `config_id` bigint NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `config_key` varchar(100) NOT NULL COMMENT '配置键',
  `config_value` text COMMENT '配置值',
  `config_type` varchar(50) DEFAULT 'string' COMMENT '配置类型(string/number/boolean/json)',
  `config_group` varchar(50) DEFAULT 'system' COMMENT '配置分组',
  `config_description` varchar(200) DEFAULT NULL COMMENT '配置说明',
  `is_system` char(1) DEFAULT '0' COMMENT '是否系统配置(0否 1是)',
  `is_encrypted` char(1) DEFAULT '0' COMMENT '是否加密(0否 1是)',
  `sort_order` int DEFAULT '0' COMMENT '排序',
  `status` char(1) DEFAULT '0' COMMENT '状态(0正常 1禁用)',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户ID',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `user_id` bigint DEFAULT NULL COMMENT '关联用户id',
  `dept_id` bigint DEFAULT NULL COMMENT '关联部门id',
  PRIMARY KEY (`config_id`),
  UNIQUE KEY `uk_config_key` (`config_key`),
  KEY `idx_group` (`config_group`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='平台配置表';

-- ----------------------------
-- Records of hit_platform_config
-- ----------------------------
INSERT INTO `hit_platform_config` VALUES ('1', 'max_project_members', '20', 'number', 'project', '项目最大成员数限制', '1', '0', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');
INSERT INTO `hit_platform_config` VALUES ('2', 'application_review_days', '7', 'number', 'project', '项目申请审核期限(天)', '1', '0', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');
INSERT INTO `hit_platform_config` VALUES ('3', 'mentor_max_projects', '10', 'number', 'mentor', '导师最大指导项目数', '1', '0', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');
INSERT INTO `hit_platform_config` VALUES ('4', 'notification_retention_days', '30', 'number', 'notification', '通知保留天数', '1', '0', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');
INSERT INTO `hit_platform_config` VALUES ('5', 'user_reputation_initial', '100', 'number', 'user', '用户初始信誉分', '1', '0', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');
INSERT INTO `hit_platform_config` VALUES ('6', 'project_featured_count', '10', 'number', 'project', '首页精选项目数量', '1', '0', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');
INSERT INTO `hit_platform_config` VALUES ('7', 'enable_auto_match', 'true', 'boolean', 'system', '是否启用智能匹配', '1', '0', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');
INSERT INTO `hit_platform_config` VALUES ('8', 'platform_announcement', '欢迎使用HIT项目组队通！', 'string', 'system', '平台公告', '0', '0', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');

-- ----------------------------
-- Table structure for hit_project
-- ----------------------------
DROP TABLE IF EXISTS `hit_project`;
CREATE TABLE `hit_project` (
  `project_id` bigint NOT NULL AUTO_INCREMENT COMMENT '项目ID',
  `project_name` varchar(100) NOT NULL COMMENT '项目名称',
  `project_description` text COMMENT '项目描述',
  `project_background` text COMMENT '项目背景',
  `project_goals` text COMMENT '项目目标',
  `expected_outcome` text COMMENT '预期成果',
  `cover_image` varchar(500) DEFAULT NULL COMMENT '项目封面',
  `project_type` varchar(50) NOT NULL COMMENT '项目类型(academic/competition/practice/graduation/course)',
  `project_category` varchar(50) DEFAULT NULL COMMENT '项目分类(computer/electronic/mechanical等)',
  `difficulty_level` tinyint DEFAULT '1' COMMENT '难度等级(1入门 2进阶 3专业 4挑战)',
  `duration_type` varchar(20) DEFAULT 'medium' COMMENT '周期类型(short/medium/long)',
  `start_date` date DEFAULT NULL COMMENT '开始日期',
  `end_date` date DEFAULT NULL COMMENT '结束日期',
  `team_size_min` int DEFAULT '1' COMMENT '最小团队规模',
  `team_size_max` int DEFAULT '10' COMMENT '最大团队规模',
  `current_members` int DEFAULT '1' COMMENT '当前成员数',
  `status` varchar(20) DEFAULT 'recruiting' COMMENT '项目状态(recruiting/ongoing/completed/paused/cancelled)',
  `recruitment_status` varchar(20) DEFAULT 'open' COMMENT '招募状态(open/paused/closed)',
  `visibility` varchar(20) DEFAULT 'public' COMMENT '可见性(public/internal/private)',
  `approval_mode` varchar(20) DEFAULT 'manual' COMMENT '审核模式(auto/manual)',
  `view_count` int DEFAULT '0' COMMENT '浏览次数',
  `like_count` int DEFAULT '0' COMMENT '点赞次数',
  `collect_count` int DEFAULT '0' COMMENT '收藏次数',
  `apply_count` int DEFAULT '0' COMMENT '申请次数',
  `is_featured` char(1) DEFAULT '0' COMMENT '是否精选(0否 1是)',
  `is_urgent` char(1) DEFAULT '0' COMMENT '是否紧急招募(0否 1是)',
  `is_credit` char(1) DEFAULT '0' COMMENT '是否学分认定(0否 1是)',
  `creator_id` bigint NOT NULL COMMENT '创建者ID',
  `mentor_id` bigint DEFAULT NULL COMMENT '指导老师ID',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户ID',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `user_id` bigint DEFAULT NULL COMMENT '关联用户id',
  `dept_id` bigint DEFAULT NULL COMMENT '关联部门id',
  PRIMARY KEY (`project_id`),
  KEY `idx_creator` (`creator_id`),
  KEY `idx_mentor` (`mentor_id`),
  KEY `idx_status` (`status`),
  KEY `idx_type` (`project_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='项目信息表';

-- ----------------------------
-- Records of hit_project
-- ----------------------------

-- ----------------------------
-- Table structure for hit_project_application
-- ----------------------------
DROP TABLE IF EXISTS `hit_project_application`;
CREATE TABLE `hit_project_application` (
  `application_id` bigint NOT NULL AUTO_INCREMENT COMMENT '申请ID',
  `project_id` bigint NOT NULL COMMENT '项目ID',
  `user_id` bigint NOT NULL COMMENT '申请人ID',
  `role_id` bigint DEFAULT NULL COMMENT '申请角色ID',
  `application_reason` text COMMENT '申请理由',
  `self_introduction` text COMMENT '自我介绍',
  `relevant_experience` text COMMENT '相关经验',
  `expected_contribution` text COMMENT '预期贡献',
  `available_time` varchar(200) DEFAULT NULL COMMENT '可投入时间',
  `contact_info` varchar(200) DEFAULT NULL COMMENT '联系方式',
  `resume_url` varchar(500) DEFAULT NULL COMMENT '简历附件',
  `portfolio_url` varchar(500) DEFAULT NULL COMMENT '作品集地址',
  `application_status` varchar(20) DEFAULT 'pending' COMMENT '申请状态(pending/reviewing/approved/rejected/withdrawn)',
  `review_result` text COMMENT '审核结果',
  `review_time` datetime DEFAULT NULL COMMENT '审核时间',
  `reviewer_id` bigint DEFAULT NULL COMMENT '审核人ID',
  `interview_time` datetime DEFAULT NULL COMMENT '面试时间',
  `interview_notes` text COMMENT '面试记录',
  `priority_score` decimal(5,2) DEFAULT '0.00' COMMENT '优先级评分',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户ID',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `dept_id` bigint DEFAULT NULL COMMENT '关联部门id',
  PRIMARY KEY (`application_id`),
  KEY `idx_project` (`project_id`),
  KEY `idx_user` (`user_id`),
  KEY `idx_status` (`application_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='项目申请表';

-- ----------------------------
-- Records of hit_project_application
-- ----------------------------

-- ----------------------------
-- Table structure for hit_project_collection
-- ----------------------------
DROP TABLE IF EXISTS `hit_project_collection`;
CREATE TABLE `hit_project_collection` (
  `collection_id` bigint NOT NULL AUTO_INCREMENT COMMENT '收藏ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `project_id` bigint NOT NULL COMMENT '项目ID',
  `collection_type` varchar(20) DEFAULT 'interested' COMMENT '收藏类型(interested/applied/following)',
  `collection_notes` varchar(500) DEFAULT NULL COMMENT '收藏备注',
  `is_notified` char(1) DEFAULT '1' COMMENT '是否接收通知(0否 1是)',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户ID',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `dept_id` bigint DEFAULT NULL COMMENT '关联部门id',
  PRIMARY KEY (`collection_id`),
  UNIQUE KEY `uk_user_project` (`user_id`,`project_id`),
  KEY `idx_project` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='项目收藏表';

-- ----------------------------
-- Records of hit_project_collection
-- ----------------------------

-- ----------------------------
-- Table structure for hit_project_evaluation
-- ----------------------------
DROP TABLE IF EXISTS `hit_project_evaluation`;
CREATE TABLE `hit_project_evaluation` (
  `evaluation_id` bigint NOT NULL AUTO_INCREMENT COMMENT '评价ID',
  `project_id` bigint NOT NULL COMMENT '项目ID',
  `evaluator_id` bigint NOT NULL COMMENT '评价人ID',
  `evaluator_type` varchar(20) NOT NULL COMMENT '评价人类型(member/mentor/peer)',
  `target_user_id` bigint DEFAULT NULL COMMENT '被评价用户ID',
  `professional_score` tinyint DEFAULT '5' COMMENT '专业能力评分(1-5)',
  `teamwork_score` tinyint DEFAULT '5' COMMENT '团队协作评分(1-5)',
  `communication_score` tinyint DEFAULT '5' COMMENT '沟通能力评分(1-5)',
  `responsibility_score` tinyint DEFAULT '5' COMMENT '责任心评分(1-5)',
  `innovation_score` tinyint DEFAULT '5' COMMENT '创新能力评分(1-5)',
  `overall_score` decimal(3,2) DEFAULT '5.00' COMMENT '综合评分',
  `project_quality_score` tinyint DEFAULT '5' COMMENT '项目质量评分(1-5)',
  `completion_score` tinyint DEFAULT '5' COMMENT '完成度评分(1-5)',
  `comment` text COMMENT '评价内容',
  `suggestions` text COMMENT '改进建议',
  `highlights` text COMMENT '亮点描述',
  `is_public` char(1) DEFAULT '1' COMMENT '是否公开(0否 1是)',
  `evaluation_phase` varchar(20) DEFAULT 'final' COMMENT '评价阶段(midterm/final/post)',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户ID',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `user_id` bigint DEFAULT NULL COMMENT '关联用户id',
  `dept_id` bigint DEFAULT NULL COMMENT '关联部门id',
  PRIMARY KEY (`evaluation_id`),
  KEY `idx_project` (`project_id`),
  KEY `idx_evaluator` (`evaluator_id`),
  KEY `idx_target_user` (`target_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='项目评价表';

-- ----------------------------
-- Records of hit_project_evaluation
-- ----------------------------

-- ----------------------------
-- Table structure for hit_project_member
-- ----------------------------
DROP TABLE IF EXISTS `hit_project_member`;
CREATE TABLE `hit_project_member` (
  `member_id` bigint NOT NULL AUTO_INCREMENT COMMENT '成员ID',
  `project_id` bigint NOT NULL COMMENT '项目ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint DEFAULT NULL COMMENT '角色ID',
  `member_role` varchar(50) DEFAULT NULL COMMENT '成员角色',
  `join_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '加入时间',
  `leave_time` datetime DEFAULT NULL COMMENT '离开时间',
  `member_status` varchar(20) DEFAULT 'active' COMMENT '成员状态(active/inactive/left)',
  `contribution_score` decimal(5,2) DEFAULT '0.00' COMMENT '贡献度评分',
  `completed_tasks` int DEFAULT '0' COMMENT '完成任务数',
  `total_tasks` int DEFAULT '0' COMMENT '总任务数',
  `work_hours` decimal(8,2) DEFAULT '0.00' COMMENT '工作时长',
  `performance_rating` decimal(3,2) DEFAULT '0.00' COMMENT '表现评分',
  `is_leader` char(1) DEFAULT '0' COMMENT '是否组长(0否 1是)',
  `permissions` text COMMENT '权限列表(JSON格式)',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户ID',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `dept_id` bigint DEFAULT NULL COMMENT '关联部门id',
  PRIMARY KEY (`member_id`),
  UNIQUE KEY `uk_project_user` (`project_id`,`user_id`),
  KEY `idx_user` (`user_id`),
  KEY `idx_role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='项目成员表';

-- ----------------------------
-- Records of hit_project_member
-- ----------------------------

-- ----------------------------
-- Table structure for hit_project_milestone
-- ----------------------------
DROP TABLE IF EXISTS `hit_project_milestone`;
CREATE TABLE `hit_project_milestone` (
  `milestone_id` bigint NOT NULL AUTO_INCREMENT COMMENT '里程碑ID',
  `project_id` bigint NOT NULL COMMENT '项目ID',
  `milestone_name` varchar(100) NOT NULL COMMENT '里程碑名称',
  `milestone_description` text COMMENT '里程碑描述',
  `target_date` date NOT NULL COMMENT '目标日期',
  `actual_date` date DEFAULT NULL COMMENT '实际完成日期',
  `status` varchar(20) DEFAULT 'pending' COMMENT '状态(pending/in_progress/completed/delayed)',
  `progress` tinyint DEFAULT '0' COMMENT '完成进度(0-100)',
  `deliverables` text COMMENT '交付物列表(JSON格式)',
  `success_criteria` text COMMENT '成功标准',
  `dependencies` text COMMENT '依赖条件',
  `is_key_milestone` char(1) DEFAULT '0' COMMENT '是否关键里程碑(0否 1是)',
  `sort_order` int DEFAULT '0' COMMENT '排序',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户ID',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `user_id` bigint DEFAULT NULL COMMENT '关联用户id',
  `dept_id` bigint DEFAULT NULL COMMENT '关联部门id',
  PRIMARY KEY (`milestone_id`),
  KEY `idx_project` (`project_id`),
  KEY `idx_target_date` (`target_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='项目里程碑表';

-- ----------------------------
-- Records of hit_project_milestone
-- ----------------------------

-- ----------------------------
-- Table structure for hit_project_role
-- ----------------------------
DROP TABLE IF EXISTS `hit_project_role`;
CREATE TABLE `hit_project_role` (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `project_id` bigint NOT NULL COMMENT '项目ID',
  `role_name` varchar(50) NOT NULL COMMENT '角色名称',
  `role_description` text COMMENT '角色描述',
  `required_skills` text COMMENT '所需技能(JSON格式)',
  `responsibilities` text COMMENT '职责描述',
  `required_count` int DEFAULT '1' COMMENT '需要人数',
  `current_count` int DEFAULT '0' COMMENT '当前人数',
  `experience_required` varchar(50) DEFAULT NULL COMMENT '经验要求',
  `time_commitment` varchar(100) DEFAULT NULL COMMENT '时间投入要求',
  `is_leader` char(1) DEFAULT '0' COMMENT '是否领导角色(0否 1是)',
  `priority` int DEFAULT '0' COMMENT '优先级',
  `status` char(1) DEFAULT '0' COMMENT '状态(0招募中 1已满 2暂停)',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户ID',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `user_id` bigint DEFAULT NULL COMMENT '关联用户id',
  `dept_id` bigint DEFAULT NULL COMMENT '关联部门id',
  PRIMARY KEY (`role_id`),
  KEY `idx_project` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='项目角色定义表';

-- ----------------------------
-- Records of hit_project_role
-- ----------------------------

-- ----------------------------
-- Table structure for hit_project_skill_requirement
-- ----------------------------
DROP TABLE IF EXISTS `hit_project_skill_requirement`;
CREATE TABLE `hit_project_skill_requirement` (
  `requirement_id` bigint NOT NULL AUTO_INCREMENT COMMENT '需求ID',
  `project_id` bigint NOT NULL COMMENT '项目ID',
  `role_id` bigint DEFAULT NULL COMMENT '角色ID',
  `tag_id` bigint NOT NULL COMMENT '技能标签ID',
  `required_level` tinyint DEFAULT '1' COMMENT '要求等级(1了解 2熟悉 3熟练 4精通 5专家)',
  `is_required` char(1) DEFAULT '1' COMMENT '是否必需(0否 1是)',
  `priority` int DEFAULT '0' COMMENT '优先级',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户ID',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `user_id` bigint DEFAULT NULL COMMENT '关联用户id',
  `dept_id` bigint DEFAULT NULL COMMENT '关联部门id',
  PRIMARY KEY (`requirement_id`),
  KEY `idx_project` (`project_id`),
  KEY `idx_role` (`role_id`),
  KEY `idx_tag` (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='项目技能要求表';

-- ----------------------------
-- Records of hit_project_skill_requirement
-- ----------------------------

-- ----------------------------
-- Table structure for hit_project_task
-- ----------------------------
DROP TABLE IF EXISTS `hit_project_task`;
CREATE TABLE `hit_project_task` (
  `task_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `project_id` bigint NOT NULL COMMENT '项目ID',
  `parent_task_id` bigint DEFAULT '0' COMMENT '父任务ID',
  `task_name` varchar(100) NOT NULL COMMENT '任务名称',
  `task_description` text COMMENT '任务描述',
  `task_type` varchar(50) DEFAULT 'feature' COMMENT '任务类型(feature/bug/optimization/test)',
  `priority` varchar(20) DEFAULT 'medium' COMMENT '优先级(low/medium/high/urgent)',
  `status` varchar(20) DEFAULT 'todo' COMMENT '状态(todo/doing/testing/done/cancelled)',
  `progress` tinyint DEFAULT '0' COMMENT '进度百分比(0-100)',
  `assignee_id` bigint DEFAULT NULL COMMENT '负责人ID',
  `creator_id` bigint NOT NULL COMMENT '创建人ID',
  `estimated_hours` decimal(6,2) DEFAULT '0.00' COMMENT '预估工时',
  `actual_hours` decimal(6,2) DEFAULT '0.00' COMMENT '实际工时',
  `start_date` date DEFAULT NULL COMMENT '开始日期',
  `due_date` date DEFAULT NULL COMMENT '截止日期',
  `completed_date` datetime DEFAULT NULL COMMENT '完成时间',
  `dependencies` text COMMENT '依赖任务ID列表(JSON格式)',
  `tags` varchar(500) DEFAULT NULL COMMENT '标签',
  `attachments` text COMMENT '附件列表(JSON格式)',
  `is_milestone` char(1) DEFAULT '0' COMMENT '是否里程碑(0否 1是)',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户ID',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `user_id` bigint DEFAULT NULL COMMENT '关联用户id',
  `dept_id` bigint DEFAULT NULL COMMENT '关联部门id',
  PRIMARY KEY (`task_id`),
  KEY `idx_project` (`project_id`),
  KEY `idx_assignee` (`assignee_id`),
  KEY `idx_status` (`status`),
  KEY `idx_parent` (`parent_task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='项目任务表';

-- ----------------------------
-- Records of hit_project_task
-- ----------------------------

-- ----------------------------
-- Table structure for hit_skill_tag
-- ----------------------------
DROP TABLE IF EXISTS `hit_skill_tag`;
CREATE TABLE `hit_skill_tag` (
  `tag_id` bigint NOT NULL AUTO_INCREMENT COMMENT '技能标签ID',
  `tag_name` varchar(50) NOT NULL COMMENT '标签名称',
  `tag_category` varchar(50) NOT NULL COMMENT '标签分类(programming/framework/design/soft_skill/hobby)',
  `tag_description` varchar(200) DEFAULT NULL COMMENT '标签描述',
  `parent_id` bigint DEFAULT '0' COMMENT '父级标签ID',
  `sort_order` int DEFAULT '0' COMMENT '排序',
  `is_hot` char(1) DEFAULT '0' COMMENT '是否热门(0否 1是)',
  `use_count` int DEFAULT '0' COMMENT '使用次数',
  `status` char(1) DEFAULT '0' COMMENT '状态(0正常 1禁用)',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户ID',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `user_id` bigint DEFAULT NULL COMMENT '关联用户id',
  `dept_id` bigint DEFAULT NULL COMMENT '关联部门id',
  PRIMARY KEY (`tag_id`),
  KEY `idx_category` (`tag_category`),
  KEY `idx_parent` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='技能标签表';

-- ----------------------------
-- Records of hit_skill_tag
-- ----------------------------
INSERT INTO `hit_skill_tag` VALUES ('1', 'Java', 'programming', 'Java编程语言', '0', '1', '1', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');
INSERT INTO `hit_skill_tag` VALUES ('2', 'Python', 'programming', 'Python编程语言', '0', '2', '1', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');
INSERT INTO `hit_skill_tag` VALUES ('3', 'JavaScript', 'programming', 'JavaScript编程语言', '0', '3', '1', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');
INSERT INTO `hit_skill_tag` VALUES ('4', 'C++', 'programming', 'C++编程语言', '0', '4', '1', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');
INSERT INTO `hit_skill_tag` VALUES ('5', 'C', 'programming', 'C编程语言', '0', '5', '0', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');
INSERT INTO `hit_skill_tag` VALUES ('6', 'Go', 'programming', 'Go编程语言', '0', '6', '0', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');
INSERT INTO `hit_skill_tag` VALUES ('7', 'Rust', 'programming', 'Rust编程语言', '0', '7', '0', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');
INSERT INTO `hit_skill_tag` VALUES ('8', 'Spring Boot', 'framework', 'Java企业级开发框架', '0', '1', '1', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');
INSERT INTO `hit_skill_tag` VALUES ('9', 'Vue.js', 'framework', '前端开发框架', '0', '2', '1', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');
INSERT INTO `hit_skill_tag` VALUES ('10', 'React', 'framework', '前端开发框架', '0', '3', '1', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');
INSERT INTO `hit_skill_tag` VALUES ('11', 'Django', 'framework', 'Python Web框架', '0', '4', '0', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');
INSERT INTO `hit_skill_tag` VALUES ('12', 'Flask', 'framework', 'Python Web框架', '0', '5', '0', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');
INSERT INTO `hit_skill_tag` VALUES ('13', 'Node.js', 'framework', 'JavaScript运行环境', '0', '6', '1', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');
INSERT INTO `hit_skill_tag` VALUES ('14', '算法设计', 'design', '算法设计与分析', '0', '1', '1', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');
INSERT INTO `hit_skill_tag` VALUES ('15', '数据分析', 'design', '数据挖掘与分析', '0', '2', '1', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');
INSERT INTO `hit_skill_tag` VALUES ('16', 'UI设计', 'design', '用户界面设计', '0', '3', '1', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');
INSERT INTO `hit_skill_tag` VALUES ('17', 'UX设计', 'design', '用户体验设计', '0', '4', '0', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');
INSERT INTO `hit_skill_tag` VALUES ('18', '机器学习', 'design', '机器学习算法', '0', '5', '1', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');
INSERT INTO `hit_skill_tag` VALUES ('19', '深度学习', 'design', '深度学习技术', '0', '6', '1', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');
INSERT INTO `hit_skill_tag` VALUES ('20', '团队协作', 'soft_skill', '团队合作能力', '0', '1', '1', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');
INSERT INTO `hit_skill_tag` VALUES ('21', '项目管理', 'soft_skill', '项目管理能力', '0', '2', '1', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');
INSERT INTO `hit_skill_tag` VALUES ('22', '沟通能力', 'soft_skill', '沟通表达能力', '0', '3', '1', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');
INSERT INTO `hit_skill_tag` VALUES ('23', '领导力', 'soft_skill', '领导管理能力', '0', '4', '0', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');
INSERT INTO `hit_skill_tag` VALUES ('24', '创新思维', 'soft_skill', '创新创造能力', '0', '5', '1', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');
INSERT INTO `hit_skill_tag` VALUES ('25', '编程', 'hobby', '编程开发兴趣', '0', '1', '1', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');
INSERT INTO `hit_skill_tag` VALUES ('26', '设计', 'hobby', '设计创作兴趣', '0', '2', '1', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');
INSERT INTO `hit_skill_tag` VALUES ('27', '音乐', 'hobby', '音乐爱好', '0', '3', '0', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');
INSERT INTO `hit_skill_tag` VALUES ('28', '运动', 'hobby', '体育运动', '0', '4', '0', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');
INSERT INTO `hit_skill_tag` VALUES ('29', '阅读', 'hobby', '阅读学习', '0', '5', '0', '0', '0', '000000', null, '1', '2025-08-11 16:14:43', null, '2025-08-11 16:14:43', '1', '103');

-- ----------------------------
-- Table structure for hit_task_comment
-- ----------------------------
DROP TABLE IF EXISTS `hit_task_comment`;
CREATE TABLE `hit_task_comment` (
  `comment_id` bigint NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `task_id` bigint NOT NULL COMMENT '任务ID',
  `user_id` bigint NOT NULL COMMENT '评论人ID',
  `parent_comment_id` bigint DEFAULT '0' COMMENT '父评论ID',
  `comment_content` text NOT NULL COMMENT '评论内容',
  `comment_type` varchar(20) DEFAULT 'normal' COMMENT '评论类型(normal/status_change/file_upload)',
  `mentioned_users` text COMMENT '提及用户ID列表(JSON格式)',
  `attachments` text COMMENT '附件列表(JSON格式)',
  `like_count` int DEFAULT '0' COMMENT '点赞数',
  `is_pinned` char(1) DEFAULT '0' COMMENT '是否置顶(0否 1是)',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户ID',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `dept_id` bigint DEFAULT NULL COMMENT '关联部门id',
  PRIMARY KEY (`comment_id`),
  KEY `idx_task` (`task_id`),
  KEY `idx_user` (`user_id`),
  KEY `idx_parent` (`parent_comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='任务评论表';

-- ----------------------------
-- Records of hit_task_comment
-- ----------------------------

-- ----------------------------
-- Table structure for hit_user_behavior_log
-- ----------------------------
DROP TABLE IF EXISTS `hit_user_behavior_log`;
CREATE TABLE `hit_user_behavior_log` (
  `log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `user_id` bigint DEFAULT NULL COMMENT '用户ID',
  `behavior_type` varchar(50) NOT NULL COMMENT '行为类型(view/like/collect/apply/search等)',
  `target_type` varchar(50) NOT NULL COMMENT '目标类型(project/user/mentor等)',
  `target_id` bigint DEFAULT NULL COMMENT '目标ID',
  `behavior_detail` text COMMENT '行为详情(JSON格式)',
  `ip_address` varchar(50) DEFAULT NULL COMMENT 'IP地址',
  `user_agent` varchar(500) DEFAULT NULL COMMENT '用户代理',
  `platform` varchar(20) DEFAULT 'web' COMMENT '平台(web/miniprogram/app)',
  `session_id` varchar(100) DEFAULT NULL COMMENT '会话ID',
  `duration` int DEFAULT '0' COMMENT '停留时长(秒)',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户ID',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `dept_id` bigint DEFAULT NULL COMMENT '关联部门id',
  PRIMARY KEY (`log_id`),
  KEY `idx_user` (`user_id`),
  KEY `idx_behavior` (`behavior_type`),
  KEY `idx_target` (`target_type`,`target_id`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户行为日志表';

-- ----------------------------
-- Records of hit_user_behavior_log
-- ----------------------------

-- ----------------------------
-- Table structure for hit_user_follow
-- ----------------------------
DROP TABLE IF EXISTS `hit_user_follow`;
CREATE TABLE `hit_user_follow` (
  `follow_id` bigint NOT NULL AUTO_INCREMENT COMMENT '关注ID',
  `follower_id` bigint NOT NULL COMMENT '关注者ID',
  `following_id` bigint NOT NULL COMMENT '被关注者ID',
  `follow_type` varchar(20) DEFAULT 'user' COMMENT '关注类型(user/mentor)',
  `is_mutual` char(1) DEFAULT '0' COMMENT '是否互相关注(0否 1是)',
  `follow_source` varchar(50) DEFAULT 'manual' COMMENT '关注来源(manual/recommendation/project)',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户ID',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `user_id` bigint DEFAULT NULL COMMENT '关联用户id',
  `dept_id` bigint DEFAULT NULL COMMENT '关联部门id',
  PRIMARY KEY (`follow_id`),
  UNIQUE KEY `uk_follow_relation` (`follower_id`,`following_id`),
  KEY `idx_following` (`following_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户关注表';

-- ----------------------------
-- Records of hit_user_follow
-- ----------------------------

-- ----------------------------
-- Table structure for hit_user_portfolio
-- ----------------------------
DROP TABLE IF EXISTS `hit_user_portfolio`;
CREATE TABLE `hit_user_portfolio` (
  `portfolio_id` bigint NOT NULL AUTO_INCREMENT COMMENT '作品ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `title` varchar(100) NOT NULL COMMENT '作品标题',
  `description` text COMMENT '作品描述',
  `work_type` varchar(50) NOT NULL COMMENT '作品类型(project/design/academic/media)',
  `cover_image` varchar(500) DEFAULT NULL COMMENT '封面图片',
  `demo_url` varchar(500) DEFAULT NULL COMMENT '演示地址',
  `repository_url` varchar(500) DEFAULT NULL COMMENT '代码仓库地址',
  `download_url` varchar(500) DEFAULT NULL COMMENT '下载地址',
  `tech_stack` text COMMENT '技术栈(JSON格式)',
  `my_role` varchar(100) DEFAULT NULL COMMENT '我的角色',
  `team_size` int DEFAULT '1' COMMENT '团队规模',
  `start_date` date DEFAULT NULL COMMENT '开始日期',
  `end_date` date DEFAULT NULL COMMENT '结束日期',
  `view_count` int DEFAULT '0' COMMENT '浏览次数',
  `like_count` int DEFAULT '0' COMMENT '点赞次数',
  `is_featured` char(1) DEFAULT '0' COMMENT '是否精选(0否 1是)',
  `is_public` char(1) DEFAULT '1' COMMENT '是否公开(0否 1是)',
  `sort_order` int DEFAULT '0' COMMENT '排序',
  `status` char(1) DEFAULT '0' COMMENT '状态(0正常 1隐藏)',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户ID',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `dept_id` bigint DEFAULT NULL COMMENT '关联部门id',
  PRIMARY KEY (`portfolio_id`),
  KEY `idx_user` (`user_id`),
  KEY `idx_type` (`work_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='个人作品集表';

-- ----------------------------
-- Records of hit_user_portfolio
-- ----------------------------

-- ----------------------------
-- Table structure for hit_user_profile
-- ----------------------------
DROP TABLE IF EXISTS `hit_user_profile`;
CREATE TABLE `hit_user_profile` (
  `profile_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户档案ID',
  `user_id` bigint NOT NULL COMMENT '关联用户id',
  `student_id` varchar(20) DEFAULT NULL COMMENT '学号',
  `real_name` varchar(50) DEFAULT NULL COMMENT '真实姓名',
  `college` varchar(100) DEFAULT NULL COMMENT '所属学院',
  `major` varchar(100) DEFAULT NULL COMMENT '专业',
  `grade` varchar(20) DEFAULT NULL COMMENT '年级',
  `class_name` varchar(50) DEFAULT NULL COMMENT '班级',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机号',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `qq` varchar(20) DEFAULT NULL COMMENT 'QQ号',
  `wechat` varchar(50) DEFAULT NULL COMMENT '微信号',
  `github` varchar(100) DEFAULT NULL COMMENT 'GitHub地址',
  `linkedin` varchar(100) DEFAULT NULL COMMENT 'LinkedIn地址',
  `personal_intro` text COMMENT '个人简介',
  `career_plan` text COMMENT '职业规划',
  `avatar_url` varchar(500) DEFAULT NULL COMMENT '头像地址',
  `cover_url` varchar(500) DEFAULT NULL COMMENT '封面地址',
  `reputation_score` decimal(5,2) DEFAULT '0.00' COMMENT '信誉积分',
  `total_projects` int DEFAULT '0' COMMENT '参与项目总数',
  `completed_projects` int DEFAULT '0' COMMENT '完成项目数',
  `status` char(1) DEFAULT '0' COMMENT '状态(0正常 1禁用)',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户ID',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `dept_id` bigint DEFAULT NULL COMMENT '关联部门id',
  PRIMARY KEY (`profile_id`),
  UNIQUE KEY `uk_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户扩展档案表';

-- ----------------------------
-- Records of hit_user_profile
-- ----------------------------

-- ----------------------------
-- Table structure for hit_user_skill
-- ----------------------------
DROP TABLE IF EXISTS `hit_user_skill`;
CREATE TABLE `hit_user_skill` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `tag_id` bigint NOT NULL COMMENT '技能标签ID',
  `skill_level` tinyint DEFAULT '1' COMMENT '技能等级(1了解 2熟悉 3熟练 4精通 5专家)',
  `is_certified` char(1) DEFAULT '0' COMMENT '是否认证(0否 1是)',
  `certificate_url` varchar(500) DEFAULT NULL COMMENT '认证证书地址',
  `learning_time` int DEFAULT '0' COMMENT '学习时长(月)',
  `project_count` int DEFAULT '0' COMMENT '相关项目数量',
  `self_evaluation` varchar(500) DEFAULT NULL COMMENT '自我评价',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户ID',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `dept_id` bigint DEFAULT NULL COMMENT '关联部门id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_tag` (`user_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户技能关联表';

-- ----------------------------
-- Records of hit_user_skill
-- ----------------------------

-- ----------------------------
-- Table structure for sj_distributed_lock
-- ----------------------------
DROP TABLE IF EXISTS `sj_distributed_lock`;
CREATE TABLE `sj_distributed_lock` (
  `name` varchar(64) NOT NULL COMMENT '锁名称',
  `lock_until` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '锁定时长',
  `locked_at` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '锁定时间',
  `locked_by` varchar(255) NOT NULL COMMENT '锁定者',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='锁定表';

-- ----------------------------
-- Records of sj_distributed_lock
-- ----------------------------

-- ----------------------------
-- Table structure for sj_group_config
-- ----------------------------
DROP TABLE IF EXISTS `sj_group_config`;
CREATE TABLE `sj_group_config` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) NOT NULL DEFAULT '' COMMENT '组名称',
  `description` varchar(256) NOT NULL DEFAULT '' COMMENT '组描述',
  `token` varchar(64) NOT NULL DEFAULT 'SJ_cKqBTPzCsWA3VyuCfFoccmuIEGXjr5KT' COMMENT 'token',
  `group_status` tinyint NOT NULL DEFAULT '0' COMMENT '组状态 0、未启用 1、启用',
  `version` int NOT NULL COMMENT '版本号',
  `group_partition` int NOT NULL COMMENT '分区',
  `id_generator_mode` tinyint NOT NULL DEFAULT '1' COMMENT '唯一id生成模式 默认号段模式',
  `init_scene` tinyint NOT NULL DEFAULT '0' COMMENT '是否初始化场景 0:否 1:是',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_namespace_id_group_name` (`namespace_id`,`group_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='组配置';

-- ----------------------------
-- Records of sj_group_config
-- ----------------------------
INSERT INTO `sj_group_config` VALUES ('1', 'dev', 'ruoyi_group', '', 'SJ_cKqBTPzCsWA3VyuCfFoccmuIEGXjr5KT', '1', '1', '0', '1', '1', '2025-08-08 13:49:52', '2025-08-08 13:49:52');
INSERT INTO `sj_group_config` VALUES ('2', 'prod', 'ruoyi_group', '', 'SJ_cKqBTPzCsWA3VyuCfFoccmuIEGXjr5KT', '1', '1', '0', '1', '1', '2025-08-08 13:49:52', '2025-08-08 13:49:52');

-- ----------------------------
-- Table structure for sj_job
-- ----------------------------
DROP TABLE IF EXISTS `sj_job`;
CREATE TABLE `sj_job` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) NOT NULL COMMENT '组名称',
  `job_name` varchar(64) NOT NULL COMMENT '名称',
  `args_str` text COMMENT '执行方法参数',
  `args_type` tinyint NOT NULL DEFAULT '1' COMMENT '参数类型 ',
  `next_trigger_at` bigint NOT NULL COMMENT '下次触发时间',
  `job_status` tinyint NOT NULL DEFAULT '1' COMMENT '任务状态 0、关闭、1、开启',
  `task_type` tinyint NOT NULL DEFAULT '1' COMMENT '任务类型 1、集群 2、广播 3、切片',
  `route_key` tinyint NOT NULL DEFAULT '4' COMMENT '路由策略',
  `executor_type` tinyint NOT NULL DEFAULT '1' COMMENT '执行器类型',
  `executor_info` varchar(255) DEFAULT NULL COMMENT '执行器名称',
  `trigger_type` tinyint NOT NULL COMMENT '触发类型 1.CRON 表达式 2. 固定时间',
  `trigger_interval` varchar(255) NOT NULL COMMENT '间隔时长',
  `block_strategy` tinyint NOT NULL DEFAULT '1' COMMENT '阻塞策略 1、丢弃 2、覆盖 3、并行 4、恢复',
  `executor_timeout` int NOT NULL DEFAULT '0' COMMENT '任务执行超时时间，单位秒',
  `max_retry_times` int NOT NULL DEFAULT '0' COMMENT '最大重试次数',
  `parallel_num` int NOT NULL DEFAULT '1' COMMENT '并行数',
  `retry_interval` int NOT NULL DEFAULT '0' COMMENT '重试间隔(s)',
  `bucket_index` int NOT NULL DEFAULT '0' COMMENT 'bucket',
  `resident` tinyint NOT NULL DEFAULT '0' COMMENT '是否是常驻任务',
  `notify_ids` varchar(128) NOT NULL DEFAULT '' COMMENT '通知告警场景配置id列表',
  `owner_id` bigint DEFAULT NULL COMMENT '负责人id',
  `description` varchar(256) NOT NULL DEFAULT '' COMMENT '描述',
  `ext_attrs` varchar(256) DEFAULT '' COMMENT '扩展字段',
  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT '逻辑删除 1、删除',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_namespace_id_group_name` (`namespace_id`,`group_name`),
  KEY `idx_job_status_bucket_index` (`job_status`,`bucket_index`),
  KEY `idx_create_dt` (`create_dt`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='任务信息';

-- ----------------------------
-- Records of sj_job
-- ----------------------------
INSERT INTO `sj_job` VALUES ('1', 'dev', 'ruoyi_group', 'demo-job', null, '1', '1710344035622', '1', '1', '4', '1', 'testJobExecutor', '2', '60', '1', '60', '3', '1', '1', '116', '0', '', '1', '', '', '0', '2025-08-08 13:49:53', '2025-08-08 13:49:53');

-- ----------------------------
-- Table structure for sj_job_log_message
-- ----------------------------
DROP TABLE IF EXISTS `sj_job_log_message`;
CREATE TABLE `sj_job_log_message` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) NOT NULL COMMENT '组名称',
  `job_id` bigint NOT NULL COMMENT '任务信息id',
  `task_batch_id` bigint NOT NULL COMMENT '任务批次id',
  `task_id` bigint NOT NULL COMMENT '调度任务id',
  `message` longtext NOT NULL COMMENT '调度信息',
  `log_num` int NOT NULL DEFAULT '1' COMMENT '日志数量',
  `real_time` bigint NOT NULL DEFAULT '0' COMMENT '上报时间',
  `ext_attrs` varchar(256) DEFAULT '' COMMENT '扩展字段',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_task_batch_id_task_id` (`task_batch_id`,`task_id`),
  KEY `idx_create_dt` (`create_dt`),
  KEY `idx_namespace_id_group_name` (`namespace_id`,`group_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='调度日志';

-- ----------------------------
-- Records of sj_job_log_message
-- ----------------------------

-- ----------------------------
-- Table structure for sj_job_summary
-- ----------------------------
DROP TABLE IF EXISTS `sj_job_summary`;
CREATE TABLE `sj_job_summary` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) NOT NULL DEFAULT '' COMMENT '组名称',
  `business_id` bigint NOT NULL COMMENT '业务id (job_id或workflow_id)',
  `system_task_type` tinyint NOT NULL DEFAULT '3' COMMENT '任务类型 3、JOB任务 4、WORKFLOW任务',
  `trigger_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '统计时间',
  `success_num` int NOT NULL DEFAULT '0' COMMENT '执行成功-日志数量',
  `fail_num` int NOT NULL DEFAULT '0' COMMENT '执行失败-日志数量',
  `fail_reason` varchar(512) NOT NULL DEFAULT '' COMMENT '失败原因',
  `stop_num` int NOT NULL DEFAULT '0' COMMENT '执行失败-日志数量',
  `stop_reason` varchar(512) NOT NULL DEFAULT '' COMMENT '失败原因',
  `cancel_num` int NOT NULL DEFAULT '0' COMMENT '执行失败-日志数量',
  `cancel_reason` varchar(512) NOT NULL DEFAULT '' COMMENT '失败原因',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_trigger_at_system_task_type_business_id` (`trigger_at`,`system_task_type`,`business_id`) USING BTREE,
  KEY `idx_namespace_id_group_name_business_id` (`namespace_id`,`group_name`,`business_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='DashBoard_Job';

-- ----------------------------
-- Records of sj_job_summary
-- ----------------------------

-- ----------------------------
-- Table structure for sj_job_task
-- ----------------------------
DROP TABLE IF EXISTS `sj_job_task`;
CREATE TABLE `sj_job_task` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) NOT NULL COMMENT '组名称',
  `job_id` bigint NOT NULL COMMENT '任务信息id',
  `task_batch_id` bigint NOT NULL COMMENT '调度任务id',
  `parent_id` bigint NOT NULL DEFAULT '0' COMMENT '父执行器id',
  `task_status` tinyint NOT NULL DEFAULT '0' COMMENT '执行的状态 0、失败 1、成功',
  `retry_count` int NOT NULL DEFAULT '0' COMMENT '重试次数',
  `mr_stage` tinyint DEFAULT NULL COMMENT '动态分片所处阶段 1:map 2:reduce 3:mergeReduce',
  `leaf` tinyint NOT NULL DEFAULT '1' COMMENT '叶子节点',
  `task_name` varchar(255) NOT NULL DEFAULT '' COMMENT '任务名称',
  `client_info` varchar(128) DEFAULT NULL COMMENT '客户端地址 clientId#ip:port',
  `wf_context` text COMMENT '工作流全局上下文',
  `result_message` text NOT NULL COMMENT '执行结果',
  `args_str` text COMMENT '执行方法参数',
  `args_type` tinyint NOT NULL DEFAULT '1' COMMENT '参数类型 ',
  `ext_attrs` varchar(256) DEFAULT '' COMMENT '扩展字段',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_task_batch_id_task_status` (`task_batch_id`,`task_status`),
  KEY `idx_create_dt` (`create_dt`),
  KEY `idx_namespace_id_group_name` (`namespace_id`,`group_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='任务实例';

-- ----------------------------
-- Records of sj_job_task
-- ----------------------------

-- ----------------------------
-- Table structure for sj_job_task_batch
-- ----------------------------
DROP TABLE IF EXISTS `sj_job_task_batch`;
CREATE TABLE `sj_job_task_batch` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) NOT NULL COMMENT '组名称',
  `job_id` bigint NOT NULL COMMENT '任务id',
  `workflow_node_id` bigint NOT NULL DEFAULT '0' COMMENT '工作流节点id',
  `parent_workflow_node_id` bigint NOT NULL DEFAULT '0' COMMENT '工作流任务父批次id',
  `workflow_task_batch_id` bigint NOT NULL DEFAULT '0' COMMENT '工作流任务批次id',
  `task_batch_status` tinyint NOT NULL DEFAULT '0' COMMENT '任务批次状态 0、失败 1、成功',
  `operation_reason` tinyint NOT NULL DEFAULT '0' COMMENT '操作原因',
  `execution_at` bigint NOT NULL DEFAULT '0' COMMENT '任务执行时间',
  `system_task_type` tinyint NOT NULL DEFAULT '3' COMMENT '任务类型 3、JOB任务 4、WORKFLOW任务',
  `parent_id` varchar(64) NOT NULL DEFAULT '' COMMENT '父节点',
  `ext_attrs` varchar(256) DEFAULT '' COMMENT '扩展字段',
  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT '逻辑删除 1、删除',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_job_id_task_batch_status` (`job_id`,`task_batch_status`),
  KEY `idx_create_dt` (`create_dt`),
  KEY `idx_namespace_id_group_name` (`namespace_id`,`group_name`),
  KEY `idx_workflow_task_batch_id_workflow_node_id` (`workflow_task_batch_id`,`workflow_node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='任务批次';

-- ----------------------------
-- Records of sj_job_task_batch
-- ----------------------------

-- ----------------------------
-- Table structure for sj_namespace
-- ----------------------------
DROP TABLE IF EXISTS `sj_namespace`;
CREATE TABLE `sj_namespace` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(64) NOT NULL COMMENT '名称',
  `unique_id` varchar(64) NOT NULL COMMENT '唯一id',
  `description` varchar(256) NOT NULL DEFAULT '' COMMENT '描述',
  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT '逻辑删除 1、删除',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='命名空间';

-- ----------------------------
-- Records of sj_namespace
-- ----------------------------
INSERT INTO `sj_namespace` VALUES ('1', 'Development', 'dev', '', '0', '2025-08-08 13:49:52', '2025-08-08 13:49:52');
INSERT INTO `sj_namespace` VALUES ('2', 'Production', 'prod', '', '0', '2025-08-08 13:49:52', '2025-08-08 13:49:52');

-- ----------------------------
-- Table structure for sj_notify_config
-- ----------------------------
DROP TABLE IF EXISTS `sj_notify_config`;
CREATE TABLE `sj_notify_config` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) NOT NULL COMMENT '组名称',
  `notify_name` varchar(64) NOT NULL DEFAULT '' COMMENT '通知名称',
  `system_task_type` tinyint NOT NULL DEFAULT '3' COMMENT '任务类型 1. 重试任务 2. 重试回调 3、JOB任务 4、WORKFLOW任务',
  `notify_status` tinyint NOT NULL DEFAULT '0' COMMENT '通知状态 0、未启用 1、启用',
  `recipient_ids` varchar(128) NOT NULL COMMENT '接收人id列表',
  `notify_threshold` int NOT NULL DEFAULT '0' COMMENT '通知阈值',
  `notify_scene` tinyint NOT NULL DEFAULT '0' COMMENT '通知场景',
  `rate_limiter_status` tinyint NOT NULL DEFAULT '0' COMMENT '限流状态 0、未启用 1、启用',
  `rate_limiter_threshold` int NOT NULL DEFAULT '0' COMMENT '每秒限流阈值',
  `description` varchar(256) NOT NULL DEFAULT '' COMMENT '描述',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_namespace_id_group_name_scene_name` (`namespace_id`,`group_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='通知配置';

-- ----------------------------
-- Records of sj_notify_config
-- ----------------------------

-- ----------------------------
-- Table structure for sj_notify_recipient
-- ----------------------------
DROP TABLE IF EXISTS `sj_notify_recipient`;
CREATE TABLE `sj_notify_recipient` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `recipient_name` varchar(64) NOT NULL COMMENT '接收人名称',
  `notify_type` tinyint NOT NULL DEFAULT '0' COMMENT '通知类型 1、钉钉 2、邮件 3、企业微信 4 飞书 5 webhook',
  `notify_attribute` varchar(512) NOT NULL COMMENT '配置属性',
  `description` varchar(256) NOT NULL DEFAULT '' COMMENT '描述',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_namespace_id` (`namespace_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='告警通知接收人';

-- ----------------------------
-- Records of sj_notify_recipient
-- ----------------------------

-- ----------------------------
-- Table structure for sj_retry
-- ----------------------------
DROP TABLE IF EXISTS `sj_retry`;
CREATE TABLE `sj_retry` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) NOT NULL COMMENT '组名称',
  `group_id` bigint NOT NULL COMMENT '组Id',
  `scene_name` varchar(64) NOT NULL COMMENT '场景名称',
  `scene_id` bigint NOT NULL COMMENT '场景ID',
  `idempotent_id` varchar(64) NOT NULL COMMENT '幂等id',
  `biz_no` varchar(64) NOT NULL DEFAULT '' COMMENT '业务编号',
  `executor_name` varchar(512) NOT NULL DEFAULT '' COMMENT '执行器名称',
  `args_str` text NOT NULL COMMENT '执行方法参数',
  `ext_attrs` text NOT NULL COMMENT '扩展字段',
  `next_trigger_at` bigint NOT NULL COMMENT '下次触发时间',
  `retry_count` int NOT NULL DEFAULT '0' COMMENT '重试次数',
  `retry_status` tinyint NOT NULL DEFAULT '0' COMMENT '重试状态 0、重试中 1、成功 2、最大重试次数',
  `task_type` tinyint NOT NULL DEFAULT '1' COMMENT '任务类型 1、重试数据 2、回调数据',
  `bucket_index` int NOT NULL DEFAULT '0' COMMENT 'bucket',
  `parent_id` bigint NOT NULL DEFAULT '0' COMMENT '父节点id',
  `deleted` bigint NOT NULL DEFAULT '0' COMMENT '逻辑删除',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_scene_tasktype_idempotentid_deleted` (`scene_id`,`task_type`,`idempotent_id`,`deleted`),
  KEY `idx_biz_no` (`biz_no`),
  KEY `idx_idempotent_id` (`idempotent_id`),
  KEY `idx_retry_status_bucket_index` (`retry_status`,`bucket_index`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_create_dt` (`create_dt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='重试信息表';

-- ----------------------------
-- Records of sj_retry
-- ----------------------------

-- ----------------------------
-- Table structure for sj_retry_dead_letter
-- ----------------------------
DROP TABLE IF EXISTS `sj_retry_dead_letter`;
CREATE TABLE `sj_retry_dead_letter` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) NOT NULL COMMENT '组名称',
  `group_id` bigint NOT NULL COMMENT '组Id',
  `scene_name` varchar(64) NOT NULL COMMENT '场景名称',
  `scene_id` bigint NOT NULL COMMENT '场景ID',
  `idempotent_id` varchar(64) NOT NULL COMMENT '幂等id',
  `biz_no` varchar(64) NOT NULL DEFAULT '' COMMENT '业务编号',
  `executor_name` varchar(512) NOT NULL DEFAULT '' COMMENT '执行器名称',
  `args_str` text NOT NULL COMMENT '执行方法参数',
  `ext_attrs` text NOT NULL COMMENT '扩展字段',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_namespace_id_group_name_scene_name` (`namespace_id`,`group_name`,`scene_name`),
  KEY `idx_idempotent_id` (`idempotent_id`),
  KEY `idx_biz_no` (`biz_no`),
  KEY `idx_create_dt` (`create_dt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='死信队列表';

-- ----------------------------
-- Records of sj_retry_dead_letter
-- ----------------------------

-- ----------------------------
-- Table structure for sj_retry_scene_config
-- ----------------------------
DROP TABLE IF EXISTS `sj_retry_scene_config`;
CREATE TABLE `sj_retry_scene_config` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `scene_name` varchar(64) NOT NULL COMMENT '场景名称',
  `group_name` varchar(64) NOT NULL COMMENT '组名称',
  `scene_status` tinyint NOT NULL DEFAULT '0' COMMENT '组状态 0、未启用 1、启用',
  `max_retry_count` int NOT NULL DEFAULT '5' COMMENT '最大重试次数',
  `back_off` tinyint NOT NULL DEFAULT '1' COMMENT '1、默认等级 2、固定间隔时间 3、CRON 表达式',
  `trigger_interval` varchar(16) NOT NULL DEFAULT '' COMMENT '间隔时长',
  `notify_ids` varchar(128) NOT NULL DEFAULT '' COMMENT '通知告警场景配置id列表',
  `deadline_request` bigint unsigned NOT NULL DEFAULT '60000' COMMENT 'Deadline Request 调用链超时 单位毫秒',
  `executor_timeout` int unsigned NOT NULL DEFAULT '5' COMMENT '任务执行超时时间，单位秒',
  `route_key` tinyint NOT NULL DEFAULT '4' COMMENT '路由策略',
  `block_strategy` tinyint NOT NULL DEFAULT '1' COMMENT '阻塞策略 1、丢弃 2、覆盖 3、并行',
  `cb_status` tinyint NOT NULL DEFAULT '0' COMMENT '回调状态 0、不开启 1、开启',
  `cb_trigger_type` tinyint NOT NULL DEFAULT '1' COMMENT '1、默认等级 2、固定间隔时间 3、CRON 表达式',
  `cb_max_count` int NOT NULL DEFAULT '16' COMMENT '回调的最大执行次数',
  `cb_trigger_interval` varchar(16) NOT NULL DEFAULT '' COMMENT '回调的最大执行次数',
  `description` varchar(256) NOT NULL DEFAULT '' COMMENT '描述',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_namespace_id_group_name_scene_name` (`namespace_id`,`group_name`,`scene_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='场景配置';

-- ----------------------------
-- Records of sj_retry_scene_config
-- ----------------------------

-- ----------------------------
-- Table structure for sj_retry_summary
-- ----------------------------
DROP TABLE IF EXISTS `sj_retry_summary`;
CREATE TABLE `sj_retry_summary` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) NOT NULL DEFAULT '' COMMENT '组名称',
  `scene_name` varchar(50) NOT NULL DEFAULT '' COMMENT '场景名称',
  `trigger_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '统计时间',
  `running_num` int NOT NULL DEFAULT '0' COMMENT '重试中-日志数量',
  `finish_num` int NOT NULL DEFAULT '0' COMMENT '重试完成-日志数量',
  `max_count_num` int NOT NULL DEFAULT '0' COMMENT '重试到达最大次数-日志数量',
  `suspend_num` int NOT NULL DEFAULT '0' COMMENT '暂停重试-日志数量',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_scene_name_trigger_at` (`namespace_id`,`group_name`,`scene_name`,`trigger_at`) USING BTREE,
  KEY `idx_trigger_at` (`trigger_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='DashBoard_Retry';

-- ----------------------------
-- Records of sj_retry_summary
-- ----------------------------

-- ----------------------------
-- Table structure for sj_retry_task
-- ----------------------------
DROP TABLE IF EXISTS `sj_retry_task`;
CREATE TABLE `sj_retry_task` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) NOT NULL COMMENT '组名称',
  `scene_name` varchar(64) NOT NULL COMMENT '场景名称',
  `retry_id` bigint NOT NULL COMMENT '重试信息Id',
  `ext_attrs` text NOT NULL COMMENT '扩展字段',
  `task_status` tinyint NOT NULL DEFAULT '1' COMMENT '重试状态',
  `task_type` tinyint NOT NULL DEFAULT '1' COMMENT '任务类型 1、重试数据 2、回调数据',
  `operation_reason` tinyint NOT NULL DEFAULT '0' COMMENT '操作原因',
  `client_info` varchar(128) DEFAULT NULL COMMENT '客户端地址 clientId#ip:port',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_group_name_scene_name` (`namespace_id`,`group_name`,`scene_name`),
  KEY `task_status` (`task_status`),
  KEY `idx_create_dt` (`create_dt`),
  KEY `idx_retry_id` (`retry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='重试任务表';

-- ----------------------------
-- Records of sj_retry_task
-- ----------------------------

-- ----------------------------
-- Table structure for sj_retry_task_log_message
-- ----------------------------
DROP TABLE IF EXISTS `sj_retry_task_log_message`;
CREATE TABLE `sj_retry_task_log_message` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) NOT NULL COMMENT '组名称',
  `retry_id` bigint NOT NULL COMMENT '重试信息Id',
  `retry_task_id` bigint NOT NULL COMMENT '重试任务Id',
  `message` longtext NOT NULL COMMENT '异常信息',
  `log_num` int NOT NULL DEFAULT '1' COMMENT '日志数量',
  `real_time` bigint NOT NULL DEFAULT '0' COMMENT '上报时间',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_namespace_id_group_name_retry_task_id` (`namespace_id`,`group_name`,`retry_task_id`),
  KEY `idx_create_dt` (`create_dt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='任务调度日志信息记录表';

-- ----------------------------
-- Records of sj_retry_task_log_message
-- ----------------------------

-- ----------------------------
-- Table structure for sj_sequence_alloc
-- ----------------------------
DROP TABLE IF EXISTS `sj_sequence_alloc`;
CREATE TABLE `sj_sequence_alloc` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) NOT NULL DEFAULT '' COMMENT '组名称',
  `max_id` bigint NOT NULL DEFAULT '1' COMMENT '最大id',
  `step` int NOT NULL DEFAULT '100' COMMENT '步长',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_namespace_id_group_name` (`namespace_id`,`group_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='号段模式序号ID分配表';

-- ----------------------------
-- Records of sj_sequence_alloc
-- ----------------------------

-- ----------------------------
-- Table structure for sj_server_node
-- ----------------------------
DROP TABLE IF EXISTS `sj_server_node`;
CREATE TABLE `sj_server_node` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) NOT NULL COMMENT '组名称',
  `host_id` varchar(64) NOT NULL COMMENT '主机id',
  `host_ip` varchar(64) NOT NULL COMMENT '机器ip',
  `host_port` int NOT NULL COMMENT '机器端口',
  `expire_at` datetime NOT NULL COMMENT '过期时间',
  `node_type` tinyint NOT NULL COMMENT '节点类型 1、客户端 2、是服务端',
  `ext_attrs` varchar(256) DEFAULT '' COMMENT '扩展字段',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_host_id_host_ip` (`host_id`,`host_ip`),
  KEY `idx_namespace_id_group_name` (`namespace_id`,`group_name`),
  KEY `idx_expire_at_node_type` (`expire_at`,`node_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='服务器节点';

-- ----------------------------
-- Records of sj_server_node
-- ----------------------------

-- ----------------------------
-- Table structure for sj_system_user
-- ----------------------------
DROP TABLE IF EXISTS `sj_system_user`;
CREATE TABLE `sj_system_user` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(64) NOT NULL COMMENT '账号',
  `password` varchar(128) NOT NULL COMMENT '密码',
  `role` tinyint NOT NULL DEFAULT '0' COMMENT '角色：1-普通用户、2-管理员',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='系统用户表';

-- ----------------------------
-- Records of sj_system_user
-- ----------------------------
INSERT INTO `sj_system_user` VALUES ('1', 'admin', '465c194afb65670f38322df087f0a9bb225cc257e43eb4ac5a0c98ef5b3173ac', '2', '2025-08-08 13:49:53', '2025-08-08 13:49:53');

-- ----------------------------
-- Table structure for sj_system_user_permission
-- ----------------------------
DROP TABLE IF EXISTS `sj_system_user_permission`;
CREATE TABLE `sj_system_user_permission` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `group_name` varchar(64) NOT NULL COMMENT '组名称',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `system_user_id` bigint NOT NULL COMMENT '系统用户id',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_namespace_id_group_name_system_user_id` (`namespace_id`,`group_name`,`system_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='系统用户权限表';

-- ----------------------------
-- Records of sj_system_user_permission
-- ----------------------------

-- ----------------------------
-- Table structure for sj_workflow
-- ----------------------------
DROP TABLE IF EXISTS `sj_workflow`;
CREATE TABLE `sj_workflow` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `workflow_name` varchar(64) NOT NULL COMMENT '工作流名称',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) NOT NULL COMMENT '组名称',
  `workflow_status` tinyint NOT NULL DEFAULT '1' COMMENT '工作流状态 0、关闭、1、开启',
  `trigger_type` tinyint NOT NULL COMMENT '触发类型 1.CRON 表达式 2. 固定时间',
  `trigger_interval` varchar(255) NOT NULL COMMENT '间隔时长',
  `next_trigger_at` bigint NOT NULL COMMENT '下次触发时间',
  `block_strategy` tinyint NOT NULL DEFAULT '1' COMMENT '阻塞策略 1、丢弃 2、覆盖 3、并行',
  `executor_timeout` int NOT NULL DEFAULT '0' COMMENT '任务执行超时时间，单位秒',
  `description` varchar(256) NOT NULL DEFAULT '' COMMENT '描述',
  `flow_info` text COMMENT '流程信息',
  `wf_context` text COMMENT '上下文',
  `notify_ids` varchar(128) NOT NULL DEFAULT '' COMMENT '通知告警场景配置id列表',
  `bucket_index` int NOT NULL DEFAULT '0' COMMENT 'bucket',
  `version` int NOT NULL COMMENT '版本号',
  `ext_attrs` varchar(256) DEFAULT '' COMMENT '扩展字段',
  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT '逻辑删除 1、删除',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_create_dt` (`create_dt`),
  KEY `idx_namespace_id_group_name` (`namespace_id`,`group_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='工作流';

-- ----------------------------
-- Records of sj_workflow
-- ----------------------------

-- ----------------------------
-- Table structure for sj_workflow_node
-- ----------------------------
DROP TABLE IF EXISTS `sj_workflow_node`;
CREATE TABLE `sj_workflow_node` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `node_name` varchar(64) NOT NULL COMMENT '节点名称',
  `group_name` varchar(64) NOT NULL COMMENT '组名称',
  `job_id` bigint NOT NULL COMMENT '任务信息id',
  `workflow_id` bigint NOT NULL COMMENT '工作流ID',
  `node_type` tinyint NOT NULL DEFAULT '1' COMMENT '1、任务节点 2、条件节点',
  `expression_type` tinyint NOT NULL DEFAULT '0' COMMENT '1、SpEl、2、Aviator 3、QL',
  `fail_strategy` tinyint NOT NULL DEFAULT '1' COMMENT '失败策略 1、跳过 2、阻塞',
  `workflow_node_status` tinyint NOT NULL DEFAULT '1' COMMENT '工作流节点状态 0、关闭、1、开启',
  `priority_level` int NOT NULL DEFAULT '1' COMMENT '优先级',
  `node_info` text COMMENT '节点信息 ',
  `version` int NOT NULL COMMENT '版本号',
  `ext_attrs` varchar(256) DEFAULT '' COMMENT '扩展字段',
  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT '逻辑删除 1、删除',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_create_dt` (`create_dt`),
  KEY `idx_namespace_id_group_name` (`namespace_id`,`group_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='工作流节点';

-- ----------------------------
-- Records of sj_workflow_node
-- ----------------------------

-- ----------------------------
-- Table structure for sj_workflow_task_batch
-- ----------------------------
DROP TABLE IF EXISTS `sj_workflow_task_batch`;
CREATE TABLE `sj_workflow_task_batch` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `namespace_id` varchar(64) NOT NULL DEFAULT '764d604ec6fc45f68cd92514c40e9e1a' COMMENT '命名空间id',
  `group_name` varchar(64) NOT NULL COMMENT '组名称',
  `workflow_id` bigint NOT NULL COMMENT '工作流任务id',
  `task_batch_status` tinyint NOT NULL DEFAULT '0' COMMENT '任务批次状态 0、失败 1、成功',
  `operation_reason` tinyint NOT NULL DEFAULT '0' COMMENT '操作原因',
  `flow_info` text COMMENT '流程信息',
  `wf_context` text COMMENT '全局上下文',
  `execution_at` bigint NOT NULL DEFAULT '0' COMMENT '任务执行时间',
  `ext_attrs` varchar(256) DEFAULT '' COMMENT '扩展字段',
  `version` int NOT NULL DEFAULT '1' COMMENT '版本号',
  `deleted` tinyint NOT NULL DEFAULT '0' COMMENT '逻辑删除 1、删除',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_job_id_task_batch_status` (`workflow_id`,`task_batch_status`),
  KEY `idx_create_dt` (`create_dt`),
  KEY `idx_namespace_id_group_name` (`namespace_id`,`group_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='工作流批次';

-- ----------------------------
-- Records of sj_workflow_task_batch
-- ----------------------------

-- ----------------------------
-- Table structure for sys_client
-- ----------------------------
DROP TABLE IF EXISTS `sys_client`;
CREATE TABLE `sys_client` (
  `id` bigint NOT NULL COMMENT 'id',
  `client_id` varchar(64) DEFAULT NULL COMMENT '客户端id',
  `client_key` varchar(32) DEFAULT NULL COMMENT '客户端key',
  `client_secret` varchar(255) DEFAULT NULL COMMENT '客户端秘钥',
  `grant_type` varchar(255) DEFAULT NULL COMMENT '授权类型',
  `device_type` varchar(32) DEFAULT NULL COMMENT '设备类型',
  `active_timeout` int DEFAULT '1800' COMMENT 'token活跃超时时间',
  `timeout` int DEFAULT '604800' COMMENT 'token固定超时',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='系统授权表';

-- ----------------------------
-- Records of sys_client
-- ----------------------------
INSERT INTO `sys_client` VALUES ('1', 'e5cd7e4891bf95d1d19206ce24a7b32e', 'pc', 'pc123', 'password,social', 'pc', '1800', '604800', '0', '0', '103', '1', '2025-08-08 13:49:43', '1', '2025-08-08 13:49:43');
INSERT INTO `sys_client` VALUES ('2', '428a8310cd442757ae699df5d894f051', 'app', 'app123', 'password,sms,social,wechat', 'android', '1800', '604800', '0', '0', '103', '1', '2025-08-08 13:49:43', '1', '2025-08-08 13:49:43');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
  `config_id` bigint NOT NULL COMMENT '参数主键',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `config_name` varchar(100) DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='参数配置表';

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES ('1', '000000', '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', '103', '1', '2025-08-08 13:49:43', null, null, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES ('2', '000000', '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', '103', '1', '2025-08-08 13:49:43', null, null, '初始化密码 123456');
INSERT INTO `sys_config` VALUES ('3', '000000', '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', '103', '1', '2025-08-08 13:49:43', null, null, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES ('5', '000000', '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', '103', '1', '2025-08-08 13:49:43', null, null, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES ('11', '000000', 'OSS预览列表资源开关', 'sys.oss.previewListResource', 'true', 'Y', '103', '1', '2025-08-08 13:49:43', null, null, 'true:开启, false:关闭');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `dept_id` bigint NOT NULL COMMENT '部门id',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `parent_id` bigint DEFAULT '0' COMMENT '父部门id',
  `ancestors` varchar(500) DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) DEFAULT '' COMMENT '部门名称',
  `dept_category` varchar(100) DEFAULT NULL COMMENT '部门类别编码',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `leader` bigint DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `status` char(1) DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='部门表';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES ('100', '000000', '0', '0', 'XXX科技', null, '0', null, '15888888888', 'xxx@qq.com', '0', '0', '103', '1', '2025-08-08 13:49:43', null, null);
INSERT INTO `sys_dept` VALUES ('101', '000000', '100', '0,100', '深圳总公司', null, '1', null, '15888888888', 'xxx@qq.com', '0', '0', '103', '1', '2025-08-08 13:49:43', null, null);
INSERT INTO `sys_dept` VALUES ('102', '000000', '100', '0,100', '长沙分公司', null, '2', null, '15888888888', 'xxx@qq.com', '0', '0', '103', '1', '2025-08-08 13:49:43', null, null);
INSERT INTO `sys_dept` VALUES ('103', '000000', '101', '0,100,101', '研发部门', null, '1', '1', '15888888888', 'xxx@qq.com', '0', '0', '103', '1', '2025-08-08 13:49:43', null, null);
INSERT INTO `sys_dept` VALUES ('104', '000000', '101', '0,100,101', '市场部门', null, '2', null, '15888888888', 'xxx@qq.com', '0', '0', '103', '1', '2025-08-08 13:49:43', null, null);
INSERT INTO `sys_dept` VALUES ('105', '000000', '101', '0,100,101', '测试部门', null, '3', null, '15888888888', 'xxx@qq.com', '0', '0', '103', '1', '2025-08-08 13:49:43', null, null);
INSERT INTO `sys_dept` VALUES ('106', '000000', '101', '0,100,101', '财务部门', null, '4', null, '15888888888', 'xxx@qq.com', '0', '0', '103', '1', '2025-08-08 13:49:43', null, null);
INSERT INTO `sys_dept` VALUES ('107', '000000', '101', '0,100,101', '运维部门', null, '5', null, '15888888888', 'xxx@qq.com', '0', '0', '103', '1', '2025-08-08 13:49:43', null, null);
INSERT INTO `sys_dept` VALUES ('108', '000000', '102', '0,100,102', '市场部门', null, '1', null, '15888888888', 'xxx@qq.com', '0', '0', '103', '1', '2025-08-08 13:49:43', null, null);
INSERT INTO `sys_dept` VALUES ('109', '000000', '102', '0,100,102', '财务部门', null, '2', null, '15888888888', 'xxx@qq.com', '0', '0', '103', '1', '2025-08-08 13:49:43', null, null);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data` (
  `dict_code` bigint NOT NULL COMMENT '字典编码',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `dict_sort` int DEFAULT '0' COMMENT '字典排序',
  `dict_label` varchar(100) DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='字典数据表';

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES ('1', '000000', '1', '男', '0', 'sys_user_sex', '', '', 'Y', '103', '1', '2025-08-08 13:49:43', null, null, '性别男');
INSERT INTO `sys_dict_data` VALUES ('2', '000000', '2', '女', '1', 'sys_user_sex', '', '', 'N', '103', '1', '2025-08-08 13:49:43', null, null, '性别女');
INSERT INTO `sys_dict_data` VALUES ('3', '000000', '3', '未知', '2', 'sys_user_sex', '', '', 'N', '103', '1', '2025-08-08 13:49:43', null, null, '性别未知');
INSERT INTO `sys_dict_data` VALUES ('4', '000000', '1', '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '103', '1', '2025-08-08 13:49:43', null, null, '显示菜单');
INSERT INTO `sys_dict_data` VALUES ('5', '000000', '2', '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '103', '1', '2025-08-08 13:49:43', null, null, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES ('6', '000000', '1', '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '103', '1', '2025-08-08 13:49:43', null, null, '正常状态');
INSERT INTO `sys_dict_data` VALUES ('7', '000000', '2', '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '103', '1', '2025-08-08 13:49:43', null, null, '停用状态');
INSERT INTO `sys_dict_data` VALUES ('12', '000000', '1', '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '103', '1', '2025-08-08 13:49:43', null, null, '系统默认是');
INSERT INTO `sys_dict_data` VALUES ('13', '000000', '2', '否', 'N', 'sys_yes_no', '', 'danger', 'N', '103', '1', '2025-08-08 13:49:43', null, null, '系统默认否');
INSERT INTO `sys_dict_data` VALUES ('14', '000000', '1', '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '103', '1', '2025-08-08 13:49:43', null, null, '通知');
INSERT INTO `sys_dict_data` VALUES ('15', '000000', '2', '公告', '2', 'sys_notice_type', '', 'success', 'N', '103', '1', '2025-08-08 13:49:43', null, null, '公告');
INSERT INTO `sys_dict_data` VALUES ('16', '000000', '1', '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '103', '1', '2025-08-08 13:49:43', null, null, '正常状态');
INSERT INTO `sys_dict_data` VALUES ('17', '000000', '2', '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '103', '1', '2025-08-08 13:49:43', null, null, '关闭状态');
INSERT INTO `sys_dict_data` VALUES ('18', '000000', '1', '新增', '1', 'sys_oper_type', '', 'info', 'N', '103', '1', '2025-08-08 13:49:43', null, null, '新增操作');
INSERT INTO `sys_dict_data` VALUES ('19', '000000', '2', '修改', '2', 'sys_oper_type', '', 'info', 'N', '103', '1', '2025-08-08 13:49:43', null, null, '修改操作');
INSERT INTO `sys_dict_data` VALUES ('20', '000000', '3', '删除', '3', 'sys_oper_type', '', 'danger', 'N', '103', '1', '2025-08-08 13:49:43', null, null, '删除操作');
INSERT INTO `sys_dict_data` VALUES ('21', '000000', '4', '授权', '4', 'sys_oper_type', '', 'primary', 'N', '103', '1', '2025-08-08 13:49:43', null, null, '授权操作');
INSERT INTO `sys_dict_data` VALUES ('22', '000000', '5', '导出', '5', 'sys_oper_type', '', 'warning', 'N', '103', '1', '2025-08-08 13:49:43', null, null, '导出操作');
INSERT INTO `sys_dict_data` VALUES ('23', '000000', '6', '导入', '6', 'sys_oper_type', '', 'warning', 'N', '103', '1', '2025-08-08 13:49:43', null, null, '导入操作');
INSERT INTO `sys_dict_data` VALUES ('24', '000000', '7', '强退', '7', 'sys_oper_type', '', 'danger', 'N', '103', '1', '2025-08-08 13:49:43', null, null, '强退操作');
INSERT INTO `sys_dict_data` VALUES ('25', '000000', '8', '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '103', '1', '2025-08-08 13:49:43', null, null, '生成操作');
INSERT INTO `sys_dict_data` VALUES ('26', '000000', '9', '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '103', '1', '2025-08-08 13:49:43', null, null, '清空操作');
INSERT INTO `sys_dict_data` VALUES ('27', '000000', '1', '成功', '0', 'sys_common_status', '', 'primary', 'N', '103', '1', '2025-08-08 13:49:43', null, null, '正常状态');
INSERT INTO `sys_dict_data` VALUES ('28', '000000', '2', '失败', '1', 'sys_common_status', '', 'danger', 'N', '103', '1', '2025-08-08 13:49:43', null, null, '停用状态');
INSERT INTO `sys_dict_data` VALUES ('29', '000000', '99', '其他', '0', 'sys_oper_type', '', 'info', 'N', '103', '1', '2025-08-08 13:49:43', null, null, '其他操作');
INSERT INTO `sys_dict_data` VALUES ('30', '000000', '0', '密码认证', 'password', 'sys_grant_type', 'el-check-tag', 'default', 'N', '103', '1', '2025-08-08 13:49:43', null, null, '密码认证');
INSERT INTO `sys_dict_data` VALUES ('31', '000000', '0', '短信认证', 'sms', 'sys_grant_type', 'el-check-tag', 'default', 'N', '103', '1', '2025-08-08 13:49:43', null, null, '短信认证');
INSERT INTO `sys_dict_data` VALUES ('32', '000000', '0', '邮件认证', 'email', 'sys_grant_type', 'el-check-tag', 'default', 'N', '103', '1', '2025-08-08 13:49:43', null, null, '邮件认证');
INSERT INTO `sys_dict_data` VALUES ('33', '000000', '0', '小程序认证', 'xcx', 'sys_grant_type', 'el-check-tag', 'default', 'N', '103', '1', '2025-08-08 13:49:43', null, null, '小程序认证');
INSERT INTO `sys_dict_data` VALUES ('34', '000000', '0', '三方登录认证', 'social', 'sys_grant_type', 'el-check-tag', 'default', 'N', '103', '1', '2025-08-08 13:49:43', null, null, '三方登录认证');
INSERT INTO `sys_dict_data` VALUES ('35', '000000', '0', 'PC', 'pc', 'sys_device_type', '', 'default', 'N', '103', '1', '2025-08-08 13:49:43', null, null, 'PC');
INSERT INTO `sys_dict_data` VALUES ('36', '000000', '0', '安卓', 'android', 'sys_device_type', '', 'default', 'N', '103', '1', '2025-08-08 13:49:43', null, null, '安卓');
INSERT INTO `sys_dict_data` VALUES ('37', '000000', '0', 'iOS', 'ios', 'sys_device_type', '', 'default', 'N', '103', '1', '2025-08-08 13:49:43', null, null, 'iOS');
INSERT INTO `sys_dict_data` VALUES ('38', '000000', '0', '小程序', 'xcx', 'sys_device_type', '', 'default', 'N', '103', '1', '2025-08-08 13:49:43', null, null, '小程序');
INSERT INTO `sys_dict_data` VALUES ('39', '000000', '1', '已撤销', 'cancel', 'wf_business_status', '', 'danger', 'N', '103', '1', '2025-08-08 13:50:02', null, null, '已撤销');
INSERT INTO `sys_dict_data` VALUES ('40', '000000', '2', '草稿', 'draft', 'wf_business_status', '', 'info', 'N', '103', '1', '2025-08-08 13:50:02', null, null, '草稿');
INSERT INTO `sys_dict_data` VALUES ('41', '000000', '3', '待审核', 'waiting', 'wf_business_status', '', 'primary', 'N', '103', '1', '2025-08-08 13:50:02', null, null, '待审核');
INSERT INTO `sys_dict_data` VALUES ('42', '000000', '4', '已完成', 'finish', 'wf_business_status', '', 'success', 'N', '103', '1', '2025-08-08 13:50:02', null, null, '已完成');
INSERT INTO `sys_dict_data` VALUES ('43', '000000', '5', '已作废', 'invalid', 'wf_business_status', '', 'danger', 'N', '103', '1', '2025-08-08 13:50:02', null, null, '已作废');
INSERT INTO `sys_dict_data` VALUES ('44', '000000', '6', '已退回', 'back', 'wf_business_status', '', 'danger', 'N', '103', '1', '2025-08-08 13:50:02', null, null, '已退回');
INSERT INTO `sys_dict_data` VALUES ('45', '000000', '7', '已终止', 'termination', 'wf_business_status', '', 'danger', 'N', '103', '1', '2025-08-08 13:50:02', null, null, '已终止');
INSERT INTO `sys_dict_data` VALUES ('46', '000000', '1', '自定义表单', 'static', 'wf_form_type', '', 'success', 'N', '103', '1', '2025-08-08 13:50:02', null, null, '自定义表单');
INSERT INTO `sys_dict_data` VALUES ('47', '000000', '2', '动态表单', 'dynamic', 'wf_form_type', '', 'primary', 'N', '103', '1', '2025-08-08 13:50:02', null, null, '动态表单');
INSERT INTO `sys_dict_data` VALUES ('48', '000000', '1', '撤销', 'cancel', 'wf_task_status', '', 'danger', 'N', '103', '1', '2025-08-08 13:50:02', null, null, '撤销');
INSERT INTO `sys_dict_data` VALUES ('49', '000000', '2', '通过', 'pass', 'wf_task_status', '', 'success', 'N', '103', '1', '2025-08-08 13:50:02', null, null, '通过');
INSERT INTO `sys_dict_data` VALUES ('50', '000000', '3', '待审核', 'waiting', 'wf_task_status', '', 'primary', 'N', '103', '1', '2025-08-08 13:50:02', null, null, '待审核');
INSERT INTO `sys_dict_data` VALUES ('51', '000000', '4', '作废', 'invalid', 'wf_task_status', '', 'danger', 'N', '103', '1', '2025-08-08 13:50:02', null, null, '作废');
INSERT INTO `sys_dict_data` VALUES ('52', '000000', '5', '退回', 'back', 'wf_task_status', '', 'danger', 'N', '103', '1', '2025-08-08 13:50:02', null, null, '退回');
INSERT INTO `sys_dict_data` VALUES ('53', '000000', '6', '终止', 'termination', 'wf_task_status', '', 'danger', 'N', '103', '1', '2025-08-08 13:50:02', null, null, '终止');
INSERT INTO `sys_dict_data` VALUES ('54', '000000', '7', '转办', 'transfer', 'wf_task_status', '', 'primary', 'N', '103', '1', '2025-08-08 13:50:02', null, null, '转办');
INSERT INTO `sys_dict_data` VALUES ('55', '000000', '8', '委托', 'depute', 'wf_task_status', '', 'primary', 'N', '103', '1', '2025-08-08 13:50:02', null, null, '委托');
INSERT INTO `sys_dict_data` VALUES ('56', '000000', '9', '抄送', 'copy', 'wf_task_status', '', 'primary', 'N', '103', '1', '2025-08-08 13:50:02', null, null, '抄送');
INSERT INTO `sys_dict_data` VALUES ('57', '000000', '10', '加签', 'sign', 'wf_task_status', '', 'primary', 'N', '103', '1', '2025-08-08 13:50:02', null, null, '加签');
INSERT INTO `sys_dict_data` VALUES ('58', '000000', '11', '减签', 'sign_off', 'wf_task_status', '', 'danger', 'N', '103', '1', '2025-08-08 13:50:02', null, null, '减签');
INSERT INTO `sys_dict_data` VALUES ('59', '000000', '11', '超时', 'timeout', 'wf_task_status', '', 'danger', 'N', '103', '1', '2025-08-08 13:50:02', null, null, '超时');
INSERT INTO `sys_dict_data` VALUES ('1001', '000000', '1', '学术研究', 'academic', 'hit_project_type', '', 'primary', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '学术研究项目');
INSERT INTO `sys_dict_data` VALUES ('1002', '000000', '2', '竞赛项目', 'competition', 'hit_project_type', '', 'success', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '各类竞赛项目');
INSERT INTO `sys_dict_data` VALUES ('1003', '000000', '3', '社会实践', 'practice', 'hit_project_type', '', 'info', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '社会实践项目');
INSERT INTO `sys_dict_data` VALUES ('1004', '000000', '4', '毕业设计', 'graduation', 'hit_project_type', '', 'warning', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '毕业设计项目');
INSERT INTO `sys_dict_data` VALUES ('1005', '000000', '5', '课程项目', 'course', 'hit_project_type', '', 'default', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '课程相关项目');
INSERT INTO `sys_dict_data` VALUES ('1011', '000000', '1', '计算机科学', 'computer', 'hit_project_category', '', 'primary', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '计算机科学与技术');
INSERT INTO `sys_dict_data` VALUES ('1012', '000000', '2', '电子信息', 'electronic', 'hit_project_category', '', 'success', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '电子信息工程');
INSERT INTO `sys_dict_data` VALUES ('1013', '000000', '3', '机械工程', 'mechanical', 'hit_project_category', '', 'info', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '机械工程');
INSERT INTO `sys_dict_data` VALUES ('1014', '000000', '4', '材料科学', 'material', 'hit_project_category', '', 'warning', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '材料科学与工程');
INSERT INTO `sys_dict_data` VALUES ('1015', '000000', '5', '土木工程', 'civil', 'hit_project_category', '', 'default', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '土木工程');
INSERT INTO `sys_dict_data` VALUES ('1016', '000000', '6', '生物医学', 'biomedical', 'hit_project_category', '', 'danger', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '生物医学工程');
INSERT INTO `sys_dict_data` VALUES ('1017', '000000', '7', '航空航天', 'aerospace', 'hit_project_category', '', 'primary', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '航空航天工程');
INSERT INTO `sys_dict_data` VALUES ('1018', '000000', '8', '能源动力', 'energy', 'hit_project_category', '', 'success', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '能源与动力工程');
INSERT INTO `sys_dict_data` VALUES ('1021', '000000', '1', '入门级', '1', 'hit_difficulty_level', '', 'success', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '适合初学者的简单项目');
INSERT INTO `sys_dict_data` VALUES ('1022', '000000', '2', '进阶级', '2', 'hit_difficulty_level', '', 'info', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '需要一定基础的项目');
INSERT INTO `sys_dict_data` VALUES ('1023', '000000', '3', '专业级', '3', 'hit_difficulty_level', '', 'warning', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '需要专业技能的项目');
INSERT INTO `sys_dict_data` VALUES ('1024', '000000', '4', '挑战级', '4', 'hit_difficulty_level', '', 'danger', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '高难度挑战性项目');
INSERT INTO `sys_dict_data` VALUES ('1031', '000000', '1', '短期项目', 'short', 'hit_duration_type', '', 'success', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '1-3个月的短期项目');
INSERT INTO `sys_dict_data` VALUES ('1032', '000000', '2', '中期项目', 'medium', 'hit_duration_type', '', 'info', 'Y', '103', '1', '2025-08-11 16:34:43', null, null, '3-6个月的中期项目');
INSERT INTO `sys_dict_data` VALUES ('1033', '000000', '3', '长期项目', 'long', 'hit_duration_type', '', 'warning', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '6个月以上的长期项目');
INSERT INTO `sys_dict_data` VALUES ('1041', '000000', '1', '招募中', 'recruiting', 'hit_project_status', '', 'primary', 'Y', '103', '1', '2025-08-11 16:34:43', null, null, '正在招募成员');
INSERT INTO `sys_dict_data` VALUES ('1042', '000000', '2', '进行中', 'ongoing', 'hit_project_status', '', 'info', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '项目正在进行');
INSERT INTO `sys_dict_data` VALUES ('1043', '000000', '3', '已完成', 'completed', 'hit_project_status', '', 'success', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '项目已完成');
INSERT INTO `sys_dict_data` VALUES ('1044', '000000', '4', '已暂停', 'paused', 'hit_project_status', '', 'warning', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '项目暂停');
INSERT INTO `sys_dict_data` VALUES ('1045', '000000', '5', '已取消', 'cancelled', 'hit_project_status', '', 'danger', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '项目已取消');
INSERT INTO `sys_dict_data` VALUES ('1051', '000000', '1', '开放招募', 'open', 'hit_recruitment_status', '', 'success', 'Y', '103', '1', '2025-08-11 16:34:43', null, null, '正在开放招募');
INSERT INTO `sys_dict_data` VALUES ('1052', '000000', '2', '暂停招募', 'paused', 'hit_recruitment_status', '', 'warning', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '暂停招募');
INSERT INTO `sys_dict_data` VALUES ('1053', '000000', '3', '停止招募', 'closed', 'hit_recruitment_status', '', 'danger', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '停止招募');
INSERT INTO `sys_dict_data` VALUES ('1061', '000000', '1', '公开', 'public', 'hit_project_visibility', '', 'success', 'Y', '103', '1', '2025-08-11 16:34:43', null, null, '所有人可见');
INSERT INTO `sys_dict_data` VALUES ('1062', '000000', '2', '校内可见', 'internal', 'hit_project_visibility', '', 'info', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '仅校内用户可见');
INSERT INTO `sys_dict_data` VALUES ('1063', '000000', '3', '私有', 'private', 'hit_project_visibility', '', 'warning', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '仅成员可见');
INSERT INTO `sys_dict_data` VALUES ('1071', '000000', '1', '自动通过', 'auto', 'hit_approval_mode', '', 'success', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '申请自动通过');
INSERT INTO `sys_dict_data` VALUES ('1072', '000000', '2', '手动审核', 'manual', 'hit_approval_mode', '', 'info', 'Y', '103', '1', '2025-08-11 16:34:43', null, null, '需要手动审核');
INSERT INTO `sys_dict_data` VALUES ('1081', '000000', '1', '待审核', 'pending', 'hit_application_status', '', 'info', 'Y', '103', '1', '2025-08-11 16:34:43', null, null, '等待审核');
INSERT INTO `sys_dict_data` VALUES ('1082', '000000', '2', '审核中', 'reviewing', 'hit_application_status', '', 'primary', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '正在审核');
INSERT INTO `sys_dict_data` VALUES ('1083', '000000', '3', '已通过', 'approved', 'hit_application_status', '', 'success', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '审核通过');
INSERT INTO `sys_dict_data` VALUES ('1084', '000000', '4', '已拒绝', 'rejected', 'hit_application_status', '', 'danger', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '审核拒绝');
INSERT INTO `sys_dict_data` VALUES ('1085', '000000', '5', '已撤回', 'withdrawn', 'hit_application_status', '', 'warning', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '申请撤回');
INSERT INTO `sys_dict_data` VALUES ('1091', '000000', '1', '活跃', 'active', 'hit_member_status', '', 'success', 'Y', '103', '1', '2025-08-11 16:34:43', null, null, '成员活跃状态');
INSERT INTO `sys_dict_data` VALUES ('1092', '000000', '2', '不活跃', 'inactive', 'hit_member_status', '', 'warning', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '成员不活跃');
INSERT INTO `sys_dict_data` VALUES ('1093', '000000', '3', '已离开', 'left', 'hit_member_status', '', 'danger', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '成员已离开');
INSERT INTO `sys_dict_data` VALUES ('1101', '000000', '1', '教授', 'professor', 'hit_mentor_title', '', 'danger', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '教授');
INSERT INTO `sys_dict_data` VALUES ('1102', '000000', '2', '副教授', 'associate_professor', 'hit_mentor_title', '', 'warning', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '副教授');
INSERT INTO `sys_dict_data` VALUES ('1103', '000000', '3', '讲师', 'lecturer', 'hit_mentor_title', '', 'info', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '讲师');
INSERT INTO `sys_dict_data` VALUES ('1104', '000000', '4', '助理教授', 'assistant_professor', 'hit_mentor_title', '', 'primary', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '助理教授');
INSERT INTO `sys_dict_data` VALUES ('1105', '000000', '5', '研究员', 'researcher', 'hit_mentor_title', '', 'success', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '研究员');
INSERT INTO `sys_dict_data` VALUES ('1106', '000000', '6', '副研究员', 'associate_researcher', 'hit_mentor_title', '', 'default', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '副研究员');
INSERT INTO `sys_dict_data` VALUES ('1111', '000000', '1', '计算机科学与技术学院', 'computer_science', 'hit_college', '', 'primary', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '计算机科学与技术学院');
INSERT INTO `sys_dict_data` VALUES ('1112', '000000', '2', '电子与信息工程学院', 'electronic_information', 'hit_college', '', 'success', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '电子与信息工程学院');
INSERT INTO `sys_dict_data` VALUES ('1113', '000000', '3', '机电工程学院', 'mechanical_electrical', 'hit_college', '', 'info', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '机电工程学院');
INSERT INTO `sys_dict_data` VALUES ('1114', '000000', '4', '材料科学与工程学院', 'materials_science', 'hit_college', '', 'warning', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '材料科学与工程学院');
INSERT INTO `sys_dict_data` VALUES ('1115', '000000', '5', '土木工程学院', 'civil_engineering', 'hit_college', '', 'default', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '土木工程学院');
INSERT INTO `sys_dict_data` VALUES ('1116', '000000', '6', '航天学院', 'aerospace', 'hit_college', '', 'danger', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '航天学院');
INSERT INTO `sys_dict_data` VALUES ('1117', '000000', '7', '能源科学与工程学院', 'energy_science', 'hit_college', '', 'primary', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '能源科学与工程学院');
INSERT INTO `sys_dict_data` VALUES ('1118', '000000', '8', '经济与管理学院', 'economics_management', 'hit_college', '', 'success', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '经济与管理学院');
INSERT INTO `sys_dict_data` VALUES ('1119', '000000', '9', '人文社科与法学学院', 'humanities_law', 'hit_college', '', 'info', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '人文社科与法学学院');
INSERT INTO `sys_dict_data` VALUES ('1120', '000000', '10', '外国语学院', 'foreign_languages', 'hit_college', '', 'warning', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '外国语学院');
INSERT INTO `sys_dict_data` VALUES ('1121', '000000', '1', '大一', 'freshman', 'hit_grade', '', 'success', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '大学一年级');
INSERT INTO `sys_dict_data` VALUES ('1122', '000000', '2', '大二', 'sophomore', 'hit_grade', '', 'info', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '大学二年级');
INSERT INTO `sys_dict_data` VALUES ('1123', '000000', '3', '大三', 'junior', 'hit_grade', '', 'warning', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '大学三年级');
INSERT INTO `sys_dict_data` VALUES ('1124', '000000', '4', '大四', 'senior', 'hit_grade', '', 'danger', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '大学四年级');
INSERT INTO `sys_dict_data` VALUES ('1125', '000000', '5', '研一', 'graduate_1', 'hit_grade', '', 'primary', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '研究生一年级');
INSERT INTO `sys_dict_data` VALUES ('1126', '000000', '6', '研二', 'graduate_2', 'hit_grade', '', 'primary', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '研究生二年级');
INSERT INTO `sys_dict_data` VALUES ('1127', '000000', '7', '研三', 'graduate_3', 'hit_grade', '', 'primary', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '研究生三年级');
INSERT INTO `sys_dict_data` VALUES ('1128', '000000', '8', '博一', 'phd_1', 'hit_grade', '', 'default', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '博士一年级');
INSERT INTO `sys_dict_data` VALUES ('1129', '000000', '9', '博二', 'phd_2', 'hit_grade', '', 'default', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '博士二年级');
INSERT INTO `sys_dict_data` VALUES ('1130', '000000', '10', '博三', 'phd_3', 'hit_grade', '', 'default', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '博士三年级');
INSERT INTO `sys_dict_data` VALUES ('1131', '000000', '11', '博四', 'phd_4', 'hit_grade', '', 'default', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '博士四年级');
INSERT INTO `sys_dict_data` VALUES ('1141', '000000', '1', '了解', '1', 'hit_skill_level', '', 'default', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '基本了解');
INSERT INTO `sys_dict_data` VALUES ('1142', '000000', '2', '熟悉', '2', 'hit_skill_level', '', 'info', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '比较熟悉');
INSERT INTO `sys_dict_data` VALUES ('1143', '000000', '3', '熟练', '3', 'hit_skill_level', '', 'primary', 'Y', '103', '1', '2025-08-11 16:34:43', null, null, '熟练掌握');
INSERT INTO `sys_dict_data` VALUES ('1144', '000000', '4', '精通', '4', 'hit_skill_level', '', 'warning', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '精通专业');
INSERT INTO `sys_dict_data` VALUES ('1145', '000000', '5', '专家', '5', 'hit_skill_level', '', 'danger', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '专家级别');
INSERT INTO `sys_dict_data` VALUES ('1151', '000000', '1', '项目作品', 'project', 'hit_work_type', '', 'primary', 'Y', '103', '1', '2025-08-11 16:34:43', null, null, '软件项目作品');
INSERT INTO `sys_dict_data` VALUES ('1152', '000000', '2', '设计作品', 'design', 'hit_work_type', '', 'success', 'N', '103', '1', '2025-08-11 16:34:43', null, null, 'UI/UX设计作品');
INSERT INTO `sys_dict_data` VALUES ('1153', '000000', '3', '学术成果', 'academic', 'hit_work_type', '', 'info', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '学术论文成果');
INSERT INTO `sys_dict_data` VALUES ('1154', '000000', '4', '媒体作品', 'media', 'hit_work_type', '', 'warning', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '视频音频作品');
INSERT INTO `sys_dict_data` VALUES ('1161', '000000', '1', '功能开发', 'feature', 'hit_task_type', '', 'primary', 'Y', '103', '1', '2025-08-11 16:34:43', null, null, '新功能开发');
INSERT INTO `sys_dict_data` VALUES ('1162', '000000', '2', '问题修复', 'bug', 'hit_task_type', '', 'danger', 'N', '103', '1', '2025-08-11 16:34:43', null, null, 'Bug修复');
INSERT INTO `sys_dict_data` VALUES ('1163', '000000', '3', '性能优化', 'optimization', 'hit_task_type', '', 'warning', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '性能优化');
INSERT INTO `sys_dict_data` VALUES ('1164', '000000', '4', '测试任务', 'test', 'hit_task_type', '', 'info', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '测试相关任务');
INSERT INTO `sys_dict_data` VALUES ('1171', '000000', '1', '低', 'low', 'hit_task_priority', '', 'default', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '低优先级');
INSERT INTO `sys_dict_data` VALUES ('1172', '000000', '2', '中', 'medium', 'hit_task_priority', '', 'info', 'Y', '103', '1', '2025-08-11 16:34:43', null, null, '中等优先级');
INSERT INTO `sys_dict_data` VALUES ('1173', '000000', '3', '高', 'high', 'hit_task_priority', '', 'warning', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '高优先级');
INSERT INTO `sys_dict_data` VALUES ('1174', '000000', '4', '紧急', 'urgent', 'hit_task_priority', '', 'danger', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '紧急优先级');
INSERT INTO `sys_dict_data` VALUES ('1181', '000000', '1', '待开始', 'todo', 'hit_task_status', '', 'default', 'Y', '103', '1', '2025-08-11 16:34:43', null, null, '待开始任务');
INSERT INTO `sys_dict_data` VALUES ('1182', '000000', '2', '进行中', 'doing', 'hit_task_status', '', 'primary', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '正在进行');
INSERT INTO `sys_dict_data` VALUES ('1183', '000000', '3', '测试中', 'testing', 'hit_task_status', '', 'info', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '测试阶段');
INSERT INTO `sys_dict_data` VALUES ('1184', '000000', '4', '已完成', 'done', 'hit_task_status', '', 'success', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '任务完成');
INSERT INTO `sys_dict_data` VALUES ('1185', '000000', '5', '已取消', 'cancelled', 'hit_task_status', '', 'danger', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '任务取消');
INSERT INTO `sys_dict_data` VALUES ('1191', '000000', '1', '待开始', 'pending', 'hit_milestone_status', '', 'default', 'Y', '103', '1', '2025-08-11 16:34:43', null, null, '待开始');
INSERT INTO `sys_dict_data` VALUES ('1192', '000000', '2', '进行中', 'in_progress', 'hit_milestone_status', '', 'primary', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '进行中');
INSERT INTO `sys_dict_data` VALUES ('1193', '000000', '3', '已完成', 'completed', 'hit_milestone_status', '', 'success', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '已完成');
INSERT INTO `sys_dict_data` VALUES ('1194', '000000', '4', '已延期', 'delayed', 'hit_milestone_status', '', 'danger', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '已延期');
INSERT INTO `sys_dict_data` VALUES ('1201', '000000', '1', '申请通知', 'application', 'hit_notification_type', '', 'primary', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '项目申请相关通知');
INSERT INTO `sys_dict_data` VALUES ('1202', '000000', '2', '审核通知', 'approval', 'hit_notification_type', '', 'info', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '审核结果通知');
INSERT INTO `sys_dict_data` VALUES ('1203', '000000', '3', '项目更新', 'project_update', 'hit_notification_type', '', 'success', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '项目信息更新');
INSERT INTO `sys_dict_data` VALUES ('1204', '000000', '4', '任务分配', 'task_assign', 'hit_notification_type', '', 'warning', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '任务分配通知');
INSERT INTO `sys_dict_data` VALUES ('1205', '000000', '5', '系统通知', 'system', 'hit_notification_type', '', 'default', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '系统公告通知');
INSERT INTO `sys_dict_data` VALUES ('1211', '000000', '1', '低', 'low', 'hit_notification_priority', '', 'default', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '低优先级通知');
INSERT INTO `sys_dict_data` VALUES ('1212', '000000', '2', '普通', 'normal', 'hit_notification_priority', '', 'info', 'Y', '103', '1', '2025-08-11 16:34:43', null, null, '普通优先级通知');
INSERT INTO `sys_dict_data` VALUES ('1213', '000000', '3', '高', 'high', 'hit_notification_priority', '', 'warning', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '高优先级通知');
INSERT INTO `sys_dict_data` VALUES ('1214', '000000', '4', '紧急', 'urgent', 'hit_notification_priority', '', 'danger', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '紧急通知');
INSERT INTO `sys_dict_data` VALUES ('1221', '000000', '1', '站内消息', 'system', 'hit_notification_channel', '', 'primary', 'Y', '103', '1', '2025-08-11 16:34:43', null, null, '系统内消息');
INSERT INTO `sys_dict_data` VALUES ('1222', '000000', '2', '邮件通知', 'email', 'hit_notification_channel', '', 'info', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '邮件通知');
INSERT INTO `sys_dict_data` VALUES ('1223', '000000', '3', '短信通知', 'sms', 'hit_notification_channel', '', 'warning', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '短信通知');
INSERT INTO `sys_dict_data` VALUES ('1224', '000000', '4', '微信通知', 'wechat', 'hit_notification_channel', '', 'success', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '微信小程序通知');
INSERT INTO `sys_dict_data` VALUES ('1231', '000000', '1', '关注用户', 'user', 'hit_follow_type', '', 'primary', 'Y', '103', '1', '2025-08-11 16:34:43', null, null, '关注普通用户');
INSERT INTO `sys_dict_data` VALUES ('1232', '000000', '2', '关注导师', 'mentor', 'hit_follow_type', '', 'warning', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '关注导师');
INSERT INTO `sys_dict_data` VALUES ('1241', '000000', '1', '团队成员', 'member', 'hit_evaluator_type', '', 'primary', 'Y', '103', '1', '2025-08-11 16:34:43', null, null, '团队成员评价');
INSERT INTO `sys_dict_data` VALUES ('1242', '000000', '2', '指导导师', 'mentor', 'hit_evaluator_type', '', 'warning', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '导师评价');
INSERT INTO `sys_dict_data` VALUES ('1243', '000000', '3', '同行评价', 'peer', 'hit_evaluator_type', '', 'info', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '同行评价');
INSERT INTO `sys_dict_data` VALUES ('1251', '000000', '1', '中期评价', 'midterm', 'hit_evaluation_phase', '', 'info', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '项目中期评价');
INSERT INTO `sys_dict_data` VALUES ('1252', '000000', '2', '最终评价', 'final', 'hit_evaluation_phase', '', 'primary', 'Y', '103', '1', '2025-08-11 16:34:43', null, null, '项目最终评价');
INSERT INTO `sys_dict_data` VALUES ('1253', '000000', '3', '后续评价', 'post', 'hit_evaluation_phase', '', 'success', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '项目结束后评价');
INSERT INTO `sys_dict_data` VALUES ('1261', '000000', '1', '感兴趣', 'interested', 'hit_collection_type', '', 'info', 'Y', '103', '1', '2025-08-11 16:34:43', null, null, '对项目感兴趣');
INSERT INTO `sys_dict_data` VALUES ('1262', '000000', '2', '已申请', 'applied', 'hit_collection_type', '', 'warning', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '已申请加入');
INSERT INTO `sys_dict_data` VALUES ('1263', '000000', '3', '关注中', 'following', 'hit_collection_type', '', 'primary', 'N', '103', '1', '2025-08-11 16:34:43', null, null, '持续关注');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type` (
  `dict_id` bigint NOT NULL COMMENT '字典主键',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `dict_name` varchar(100) DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`),
  UNIQUE KEY `tenant_id` (`tenant_id`,`dict_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='字典类型表';

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES ('1', '000000', '用户性别', 'sys_user_sex', '103', '1', '2025-08-08 13:49:43', null, null, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES ('2', '000000', '菜单状态', 'sys_show_hide', '103', '1', '2025-08-08 13:49:43', null, null, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES ('3', '000000', '系统开关', 'sys_normal_disable', '103', '1', '2025-08-08 13:49:43', null, null, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES ('6', '000000', '系统是否', 'sys_yes_no', '103', '1', '2025-08-08 13:49:43', null, null, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES ('7', '000000', '通知类型', 'sys_notice_type', '103', '1', '2025-08-08 13:49:43', null, null, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES ('8', '000000', '通知状态', 'sys_notice_status', '103', '1', '2025-08-08 13:49:43', null, null, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES ('9', '000000', '操作类型', 'sys_oper_type', '103', '1', '2025-08-08 13:49:43', null, null, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES ('10', '000000', '系统状态', 'sys_common_status', '103', '1', '2025-08-08 13:49:43', null, null, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES ('11', '000000', '授权类型', 'sys_grant_type', '103', '1', '2025-08-08 13:49:43', null, null, '认证授权类型');
INSERT INTO `sys_dict_type` VALUES ('12', '000000', '设备类型', 'sys_device_type', '103', '1', '2025-08-08 13:49:43', null, null, '客户端设备类型');
INSERT INTO `sys_dict_type` VALUES ('13', '000000', '业务状态', 'wf_business_status', '103', '1', '2025-08-08 13:50:02', null, null, '业务状态列表');
INSERT INTO `sys_dict_type` VALUES ('14', '000000', '表单类型', 'wf_form_type', '103', '1', '2025-08-08 13:50:02', null, null, '表单类型列表');
INSERT INTO `sys_dict_type` VALUES ('15', '000000', '任务状态', 'wf_task_status', '103', '1', '2025-08-08 13:50:02', null, null, '任务状态');
INSERT INTO `sys_dict_type` VALUES ('100', '000000', '项目类型', 'hit_project_type', '103', '1', '2025-08-11 16:34:42', null, null, 'HIT项目组队通项目类型字典');
INSERT INTO `sys_dict_type` VALUES ('101', '000000', '项目分类', 'hit_project_category', '103', '1', '2025-08-11 16:34:42', null, null, 'HIT项目组队通项目分类字典');
INSERT INTO `sys_dict_type` VALUES ('102', '000000', '难度等级', 'hit_difficulty_level', '103', '1', '2025-08-11 16:34:42', null, null, 'HIT项目组队通难度等级字典');
INSERT INTO `sys_dict_type` VALUES ('103', '000000', '项目周期类型', 'hit_duration_type', '103', '1', '2025-08-11 16:34:42', null, null, 'HIT项目组队通项目周期类型字典');
INSERT INTO `sys_dict_type` VALUES ('104', '000000', '项目状态', 'hit_project_status', '103', '1', '2025-08-11 16:34:42', null, null, 'HIT项目组队通项目状态字典');
INSERT INTO `sys_dict_type` VALUES ('105', '000000', '招募状态', 'hit_recruitment_status', '103', '1', '2025-08-11 16:34:42', null, null, 'HIT项目组队通招募状态字典');
INSERT INTO `sys_dict_type` VALUES ('106', '000000', '项目可见性', 'hit_project_visibility', '103', '1', '2025-08-11 16:34:42', null, null, 'HIT项目组队通项目可见性字典');
INSERT INTO `sys_dict_type` VALUES ('107', '000000', '审核模式', 'hit_approval_mode', '103', '1', '2025-08-11 16:34:42', null, null, 'HIT项目组队通审核模式字典');
INSERT INTO `sys_dict_type` VALUES ('108', '000000', '申请状态', 'hit_application_status', '103', '1', '2025-08-11 16:34:42', null, null, 'HIT项目组队通申请状态字典');
INSERT INTO `sys_dict_type` VALUES ('109', '000000', '成员状态', 'hit_member_status', '103', '1', '2025-08-11 16:34:42', null, null, 'HIT项目组队通成员状态字典');
INSERT INTO `sys_dict_type` VALUES ('110', '000000', '导师职称', 'hit_mentor_title', '103', '1', '2025-08-11 16:34:42', null, null, 'HIT项目组队通导师职称字典');
INSERT INTO `sys_dict_type` VALUES ('111', '000000', '学院', 'hit_college', '103', '1', '2025-08-11 16:34:42', null, null, 'HIT项目组队通学院字典');
INSERT INTO `sys_dict_type` VALUES ('112', '000000', '年级', 'hit_grade', '103', '1', '2025-08-11 16:34:42', null, null, 'HIT项目组队通年级字典');
INSERT INTO `sys_dict_type` VALUES ('113', '000000', '技能等级', 'hit_skill_level', '103', '1', '2025-08-11 16:34:42', null, null, 'HIT项目组队通技能等级字典');
INSERT INTO `sys_dict_type` VALUES ('114', '000000', '作品类型', 'hit_work_type', '103', '1', '2025-08-11 16:34:42', null, null, 'HIT项目组队通作品类型字典');
INSERT INTO `sys_dict_type` VALUES ('115', '000000', '任务类型', 'hit_task_type', '103', '1', '2025-08-11 16:34:42', null, null, 'HIT项目组队通任务类型字典');
INSERT INTO `sys_dict_type` VALUES ('116', '000000', '任务优先级', 'hit_task_priority', '103', '1', '2025-08-11 16:34:42', null, null, 'HIT项目组队通任务优先级字典');
INSERT INTO `sys_dict_type` VALUES ('117', '000000', '任务状态', 'hit_task_status', '103', '1', '2025-08-11 16:34:42', null, null, 'HIT项目组队通任务状态字典');
INSERT INTO `sys_dict_type` VALUES ('118', '000000', '里程碑状态', 'hit_milestone_status', '103', '1', '2025-08-11 16:34:42', null, null, 'HIT项目组队通里程碑状态字典');
INSERT INTO `sys_dict_type` VALUES ('119', '000000', '通知类型', 'hit_notification_type', '103', '1', '2025-08-11 16:34:42', null, null, 'HIT项目组队通通知类型字典');
INSERT INTO `sys_dict_type` VALUES ('120', '000000', '通知优先级', 'hit_notification_priority', '103', '1', '2025-08-11 16:34:42', null, null, 'HIT项目组队通通知优先级字典');
INSERT INTO `sys_dict_type` VALUES ('121', '000000', '通知渠道', 'hit_notification_channel', '103', '1', '2025-08-11 16:34:42', null, null, 'HIT项目组队通通知渠道字典');
INSERT INTO `sys_dict_type` VALUES ('122', '000000', '关注类型', 'hit_follow_type', '103', '1', '2025-08-11 16:34:42', null, null, 'HIT项目组队通关注类型字典');
INSERT INTO `sys_dict_type` VALUES ('123', '000000', '评价人类型', 'hit_evaluator_type', '103', '1', '2025-08-11 16:34:43', null, null, 'HIT项目组队通评价人类型字典');
INSERT INTO `sys_dict_type` VALUES ('124', '000000', '评价阶段', 'hit_evaluation_phase', '103', '1', '2025-08-11 16:34:43', null, null, 'HIT项目组队通评价阶段字典');
INSERT INTO `sys_dict_type` VALUES ('125', '000000', '收藏类型', 'hit_collection_type', '103', '1', '2025-08-11 16:34:43', null, null, 'HIT项目组队通收藏类型字典');

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor` (
  `info_id` bigint NOT NULL COMMENT '访问ID',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `user_name` varchar(50) DEFAULT '' COMMENT '用户账号',
  `client_key` varchar(32) DEFAULT '' COMMENT '客户端',
  `device_type` varchar(32) DEFAULT '' COMMENT '设备类型',
  `ipaddr` varchar(128) DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) DEFAULT '' COMMENT '操作系统',
  `status` char(1) DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) DEFAULT '' COMMENT '提示消息',
  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`),
  KEY `idx_sys_logininfor_s` (`status`),
  KEY `idx_sys_logininfor_lt` (`login_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='系统访问记录';

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES ('1953827752346193922', '000000', '18878688656', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'MicroMessenger', 'iPhone', '0', '登录成功', '2025-08-08 22:36:51');
INSERT INTO `sys_logininfor` VALUES ('1954819907368013825', '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-08-11 16:19:19');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  `menu_name` varchar(50) NOT NULL COMMENT '菜单名称',
  `parent_id` bigint DEFAULT '0' COMMENT '父菜单ID',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `path` varchar(200) DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) DEFAULT NULL COMMENT '组件路径',
  `query_param` varchar(255) DEFAULT NULL COMMENT '路由参数',
  `is_frame` int DEFAULT '1' COMMENT '是否为外链（0是 1否）',
  `is_cache` int DEFAULT '0' COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) DEFAULT '0' COMMENT '显示状态（0显示 1隐藏）',
  `status` char(1) DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) DEFAULT '#' COMMENT '菜单图标',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='菜单权限表';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1', '系统管理', '0', '1', 'system', null, '', '1', '0', 'M', '0', '0', '', 'system', '103', '1', '2025-08-08 13:49:43', null, null, '系统管理目录');
INSERT INTO `sys_menu` VALUES ('2', '系统监控', '0', '3', 'monitor', null, '', '1', '0', 'M', '0', '1', '', 'monitor', '103', '1', '2025-08-08 13:49:43', '1', '2025-08-11 16:42:13', '系统监控目录');
INSERT INTO `sys_menu` VALUES ('3', '系统工具', '0', '4', 'tool', null, '', '1', '0', 'M', '0', '0', '', 'tool', '103', '1', '2025-08-08 13:49:43', null, null, '系统工具目录');
INSERT INTO `sys_menu` VALUES ('5', '测试菜单', '0', '5', 'demo', null, '', '1', '0', 'M', '0', '1', '', 'star', '103', '1', '2025-08-08 13:49:43', '1', '2025-08-11 16:41:58', '测试菜单');
INSERT INTO `sys_menu` VALUES ('6', '租户管理', '0', '2', 'tenant', null, '', '1', '0', 'M', '0', '1', '', 'chart', '103', '1', '2025-08-08 13:49:43', '1', '2025-08-11 16:42:19', '租户管理目录');
INSERT INTO `sys_menu` VALUES ('100', '用户管理', '1', '1', 'user', 'system/user/index', '', '1', '0', 'C', '0', '0', 'system:user:list', 'user', '103', '1', '2025-08-08 13:49:43', null, null, '用户管理菜单');
INSERT INTO `sys_menu` VALUES ('101', '角色管理', '1', '2', 'role', 'system/role/index', '', '1', '0', 'C', '0', '0', 'system:role:list', 'peoples', '103', '1', '2025-08-08 13:49:43', null, null, '角色管理菜单');
INSERT INTO `sys_menu` VALUES ('102', '菜单管理', '1', '3', 'menu', 'system/menu/index', '', '1', '0', 'C', '0', '0', 'system:menu:list', 'tree-table', '103', '1', '2025-08-08 13:49:43', null, null, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES ('103', '部门管理', '1', '4', 'dept', 'system/dept/index', '', '1', '0', 'C', '0', '0', 'system:dept:list', 'tree', '103', '1', '2025-08-08 13:49:43', null, null, '部门管理菜单');
INSERT INTO `sys_menu` VALUES ('104', '岗位管理', '1', '5', 'post', 'system/post/index', '', '1', '0', 'C', '0', '0', 'system:post:list', 'post', '103', '1', '2025-08-08 13:49:43', null, null, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES ('105', '字典管理', '1', '6', 'dict', 'system/dict/index', '', '1', '0', 'C', '0', '0', 'system:dict:list', 'dict', '103', '1', '2025-08-08 13:49:43', null, null, '字典管理菜单');
INSERT INTO `sys_menu` VALUES ('106', '参数设置', '1', '7', 'config', 'system/config/index', '', '1', '0', 'C', '0', '0', 'system:config:list', 'edit', '103', '1', '2025-08-08 13:49:43', null, null, '参数设置菜单');
INSERT INTO `sys_menu` VALUES ('107', '通知公告', '1', '8', 'notice', 'system/notice/index', '', '1', '0', 'C', '0', '0', 'system:notice:list', 'message', '103', '1', '2025-08-08 13:49:43', null, null, '通知公告菜单');
INSERT INTO `sys_menu` VALUES ('108', '日志管理', '1', '9', 'log', '', '', '1', '0', 'M', '0', '0', '', 'log', '103', '1', '2025-08-08 13:49:43', null, null, '日志管理菜单');
INSERT INTO `sys_menu` VALUES ('109', '在线用户', '2', '1', 'online', 'monitor/online/index', '', '1', '0', 'C', '0', '0', 'monitor:online:list', 'online', '103', '1', '2025-08-08 13:49:43', null, null, '在线用户菜单');
INSERT INTO `sys_menu` VALUES ('113', '缓存监控', '2', '5', 'cache', 'monitor/cache/index', '', '1', '0', 'C', '0', '0', 'monitor:cache:list', 'redis', '103', '1', '2025-08-08 13:49:43', null, null, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES ('115', '代码生成', '3', '2', 'gen', 'tool/gen/index', '', '1', '0', 'C', '0', '0', 'tool:gen:list', 'code', '103', '1', '2025-08-08 13:49:43', null, null, '代码生成菜单');
INSERT INTO `sys_menu` VALUES ('116', '修改生成配置', '3', '2', 'gen-edit/index/:tableId', 'tool/gen/editTable', '', '1', '1', 'C', '1', '0', 'tool:gen:edit', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('117', 'Admin监控', '2', '5', 'Admin', 'monitor/admin/index', '', '1', '0', 'C', '0', '0', 'monitor:admin:list', 'dashboard', '103', '1', '2025-08-08 13:49:43', null, null, 'Admin监控菜单');
INSERT INTO `sys_menu` VALUES ('118', '文件管理', '1', '10', 'oss', 'system/oss/index', '', '1', '0', 'C', '0', '0', 'system:oss:list', 'upload', '103', '1', '2025-08-08 13:49:43', null, null, '文件管理菜单');
INSERT INTO `sys_menu` VALUES ('120', '任务调度中心', '2', '6', 'snailjob', 'monitor/snailjob/index', '', '1', '0', 'C', '0', '0', 'monitor:snailjob:list', 'job', '103', '1', '2025-08-08 13:49:43', null, null, 'SnailJob控制台菜单');
INSERT INTO `sys_menu` VALUES ('121', '租户管理', '6', '1', 'tenant', 'system/tenant/index', '', '1', '0', 'C', '0', '0', 'system:tenant:list', 'list', '103', '1', '2025-08-08 13:49:43', null, null, '租户管理菜单');
INSERT INTO `sys_menu` VALUES ('122', '租户套餐管理', '6', '2', 'tenantPackage', 'system/tenantPackage/index', '', '1', '0', 'C', '0', '0', 'system:tenantPackage:list', 'form', '103', '1', '2025-08-08 13:49:43', null, null, '租户套餐管理菜单');
INSERT INTO `sys_menu` VALUES ('123', '客户端管理', '1', '11', 'client', 'system/client/index', '', '1', '0', 'C', '0', '0', 'system:client:list', 'international', '103', '1', '2025-08-08 13:49:43', null, null, '客户端管理菜单');
INSERT INTO `sys_menu` VALUES ('130', '分配用户', '1', '2', 'role-auth/user/:roleId', 'system/role/authUser', '', '1', '1', 'C', '1', '0', 'system:role:edit', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('131', '分配角色', '1', '1', 'user-auth/role/:userId', 'system/user/authRole', '', '1', '1', 'C', '1', '0', 'system:user:edit', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('132', '字典数据', '1', '6', 'dict-data/index/:dictId', 'system/dict/data', '', '1', '1', 'C', '1', '0', 'system:dict:list', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('133', '文件配置管理', '1', '10', 'oss-config/index', 'system/oss/config', '', '1', '1', 'C', '1', '0', 'system:ossConfig:list', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('500', '操作日志', '108', '1', 'operlog', 'monitor/operlog/index', '', '1', '0', 'C', '0', '0', 'monitor:operlog:list', 'form', '103', '1', '2025-08-08 13:49:43', null, null, '操作日志菜单');
INSERT INTO `sys_menu` VALUES ('501', '登录日志', '108', '2', 'logininfor', 'monitor/logininfor/index', '', '1', '0', 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', '103', '1', '2025-08-08 13:49:43', null, null, '登录日志菜单');
INSERT INTO `sys_menu` VALUES ('1001', '用户查询', '100', '1', '', '', '', '1', '0', 'F', '0', '0', 'system:user:query', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1002', '用户新增', '100', '2', '', '', '', '1', '0', 'F', '0', '0', 'system:user:add', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1003', '用户修改', '100', '3', '', '', '', '1', '0', 'F', '0', '0', 'system:user:edit', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1004', '用户删除', '100', '4', '', '', '', '1', '0', 'F', '0', '0', 'system:user:remove', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1005', '用户导出', '100', '5', '', '', '', '1', '0', 'F', '0', '0', 'system:user:export', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1006', '用户导入', '100', '6', '', '', '', '1', '0', 'F', '0', '0', 'system:user:import', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1007', '重置密码', '100', '7', '', '', '', '1', '0', 'F', '0', '0', 'system:user:resetPwd', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1008', '角色查询', '101', '1', '', '', '', '1', '0', 'F', '0', '0', 'system:role:query', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1009', '角色新增', '101', '2', '', '', '', '1', '0', 'F', '0', '0', 'system:role:add', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1010', '角色修改', '101', '3', '', '', '', '1', '0', 'F', '0', '0', 'system:role:edit', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1011', '角色删除', '101', '4', '', '', '', '1', '0', 'F', '0', '0', 'system:role:remove', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1012', '角色导出', '101', '5', '', '', '', '1', '0', 'F', '0', '0', 'system:role:export', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1013', '菜单查询', '102', '1', '', '', '', '1', '0', 'F', '0', '0', 'system:menu:query', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1014', '菜单新增', '102', '2', '', '', '', '1', '0', 'F', '0', '0', 'system:menu:add', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1015', '菜单修改', '102', '3', '', '', '', '1', '0', 'F', '0', '0', 'system:menu:edit', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1016', '菜单删除', '102', '4', '', '', '', '1', '0', 'F', '0', '0', 'system:menu:remove', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1017', '部门查询', '103', '1', '', '', '', '1', '0', 'F', '0', '0', 'system:dept:query', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1018', '部门新增', '103', '2', '', '', '', '1', '0', 'F', '0', '0', 'system:dept:add', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1019', '部门修改', '103', '3', '', '', '', '1', '0', 'F', '0', '0', 'system:dept:edit', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1020', '部门删除', '103', '4', '', '', '', '1', '0', 'F', '0', '0', 'system:dept:remove', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1021', '岗位查询', '104', '1', '', '', '', '1', '0', 'F', '0', '0', 'system:post:query', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1022', '岗位新增', '104', '2', '', '', '', '1', '0', 'F', '0', '0', 'system:post:add', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1023', '岗位修改', '104', '3', '', '', '', '1', '0', 'F', '0', '0', 'system:post:edit', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1024', '岗位删除', '104', '4', '', '', '', '1', '0', 'F', '0', '0', 'system:post:remove', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1025', '岗位导出', '104', '5', '', '', '', '1', '0', 'F', '0', '0', 'system:post:export', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1026', '字典查询', '105', '1', '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:query', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1027', '字典新增', '105', '2', '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:add', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1028', '字典修改', '105', '3', '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:edit', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1029', '字典删除', '105', '4', '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:remove', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1030', '字典导出', '105', '5', '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:export', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1031', '参数查询', '106', '1', '#', '', '', '1', '0', 'F', '0', '0', 'system:config:query', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1032', '参数新增', '106', '2', '#', '', '', '1', '0', 'F', '0', '0', 'system:config:add', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1033', '参数修改', '106', '3', '#', '', '', '1', '0', 'F', '0', '0', 'system:config:edit', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1034', '参数删除', '106', '4', '#', '', '', '1', '0', 'F', '0', '0', 'system:config:remove', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1035', '参数导出', '106', '5', '#', '', '', '1', '0', 'F', '0', '0', 'system:config:export', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1036', '公告查询', '107', '1', '#', '', '', '1', '0', 'F', '0', '0', 'system:notice:query', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1037', '公告新增', '107', '2', '#', '', '', '1', '0', 'F', '0', '0', 'system:notice:add', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1038', '公告修改', '107', '3', '#', '', '', '1', '0', 'F', '0', '0', 'system:notice:edit', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1039', '公告删除', '107', '4', '#', '', '', '1', '0', 'F', '0', '0', 'system:notice:remove', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1040', '操作查询', '500', '1', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:operlog:query', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1041', '操作删除', '500', '2', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:operlog:remove', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1042', '日志导出', '500', '4', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:operlog:export', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1043', '登录查询', '501', '1', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:query', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1044', '登录删除', '501', '2', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:remove', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1045', '日志导出', '501', '3', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:export', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1046', '在线查询', '109', '1', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:online:query', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1047', '批量强退', '109', '2', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:online:batchLogout', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1048', '单条强退', '109', '3', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:online:forceLogout', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1050', '账户解锁', '501', '4', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:unlock', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1055', '生成查询', '115', '1', '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:query', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1056', '生成修改', '115', '2', '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:edit', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1057', '生成删除', '115', '3', '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:remove', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1058', '导入代码', '115', '2', '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:import', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1059', '预览代码', '115', '4', '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:preview', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1060', '生成代码', '115', '5', '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:code', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1061', '客户端管理查询', '123', '1', '#', '', '', '1', '0', 'F', '0', '0', 'system:client:query', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1062', '客户端管理新增', '123', '2', '#', '', '', '1', '0', 'F', '0', '0', 'system:client:add', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1063', '客户端管理修改', '123', '3', '#', '', '', '1', '0', 'F', '0', '0', 'system:client:edit', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1064', '客户端管理删除', '123', '4', '#', '', '', '1', '0', 'F', '0', '0', 'system:client:remove', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1065', '客户端管理导出', '123', '5', '#', '', '', '1', '0', 'F', '0', '0', 'system:client:export', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1500', '测试单表', '5', '1', 'demo', 'demo/demo/index', '', '1', '0', 'C', '0', '0', 'demo:demo:list', '#', '103', '1', '2025-08-08 13:49:43', null, null, '测试单表菜单');
INSERT INTO `sys_menu` VALUES ('1501', '测试单表查询', '1500', '1', '#', '', '', '1', '0', 'F', '0', '0', 'demo:demo:query', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1502', '测试单表新增', '1500', '2', '#', '', '', '1', '0', 'F', '0', '0', 'demo:demo:add', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1503', '测试单表修改', '1500', '3', '#', '', '', '1', '0', 'F', '0', '0', 'demo:demo:edit', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1504', '测试单表删除', '1500', '4', '#', '', '', '1', '0', 'F', '0', '0', 'demo:demo:remove', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1505', '测试单表导出', '1500', '5', '#', '', '', '1', '0', 'F', '0', '0', 'demo:demo:export', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1506', '测试树表', '5', '1', 'tree', 'demo/tree/index', '', '1', '0', 'C', '0', '0', 'demo:tree:list', '#', '103', '1', '2025-08-08 13:49:43', null, null, '测试树表菜单');
INSERT INTO `sys_menu` VALUES ('1507', '测试树表查询', '1506', '1', '#', '', '', '1', '0', 'F', '0', '0', 'demo:tree:query', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1508', '测试树表新增', '1506', '2', '#', '', '', '1', '0', 'F', '0', '0', 'demo:tree:add', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1509', '测试树表修改', '1506', '3', '#', '', '', '1', '0', 'F', '0', '0', 'demo:tree:edit', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1510', '测试树表删除', '1506', '4', '#', '', '', '1', '0', 'F', '0', '0', 'demo:tree:remove', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1511', '测试树表导出', '1506', '5', '#', '', '', '1', '0', 'F', '0', '0', 'demo:tree:export', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1600', '文件查询', '118', '1', '#', '', '', '1', '0', 'F', '0', '0', 'system:oss:query', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1601', '文件上传', '118', '2', '#', '', '', '1', '0', 'F', '0', '0', 'system:oss:upload', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1602', '文件下载', '118', '3', '#', '', '', '1', '0', 'F', '0', '0', 'system:oss:download', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1603', '文件删除', '118', '4', '#', '', '', '1', '0', 'F', '0', '0', 'system:oss:remove', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1606', '租户查询', '121', '1', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenant:query', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1607', '租户新增', '121', '2', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenant:add', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1608', '租户修改', '121', '3', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenant:edit', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1609', '租户删除', '121', '4', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenant:remove', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1610', '租户导出', '121', '5', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenant:export', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1611', '租户套餐查询', '122', '1', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenantPackage:query', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1612', '租户套餐新增', '122', '2', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenantPackage:add', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1613', '租户套餐修改', '122', '3', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenantPackage:edit', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1614', '租户套餐删除', '122', '4', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenantPackage:remove', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1615', '租户套餐导出', '122', '5', '#', '', '', '1', '0', 'F', '0', '0', 'system:tenantPackage:export', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1620', '配置列表', '118', '5', '#', '', '', '1', '0', 'F', '0', '0', 'system:ossConfig:list', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1621', '配置添加', '118', '6', '#', '', '', '1', '0', 'F', '0', '0', 'system:ossConfig:add', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1622', '配置编辑', '118', '6', '#', '', '', '1', '0', 'F', '0', '0', 'system:ossConfig:edit', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('1623', '配置删除', '118', '6', '#', '', '', '1', '0', 'F', '0', '0', 'system:ossConfig:remove', '#', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_menu` VALUES ('11616', '工作流', '0', '6', 'workflow', '', '', '1', '0', 'M', '0', '1', '', 'workflow', '103', '1', '2025-08-08 13:50:02', '1', '2025-08-11 16:41:46', '');
INSERT INTO `sys_menu` VALUES ('11618', '我的任务', '0', '7', 'task', '', '', '1', '0', 'M', '0', '1', '', 'my-task', '103', '1', '2025-08-08 13:50:02', '1', '2025-08-11 16:41:51', '');
INSERT INTO `sys_menu` VALUES ('11619', '我的待办', '11618', '2', 'taskWaiting', 'workflow/task/taskWaiting', '', '1', '1', 'C', '0', '0', '', 'waiting', '103', '1', '2025-08-08 13:50:02', null, null, '');
INSERT INTO `sys_menu` VALUES ('11620', '流程定义', '11616', '3', 'processDefinition', 'workflow/processDefinition/index', '', '1', '1', 'C', '0', '0', '', 'process-definition', '103', '1', '2025-08-08 13:50:02', null, null, '');
INSERT INTO `sys_menu` VALUES ('11621', '流程实例', '11630', '1', 'processInstance', 'workflow/processInstance/index', '', '1', '1', 'C', '0', '0', '', 'tree-table', '103', '1', '2025-08-08 13:50:02', null, null, '');
INSERT INTO `sys_menu` VALUES ('11622', '流程分类', '11616', '1', 'category', 'workflow/category/index', '', '1', '0', 'C', '0', '0', 'workflow:category:list', 'category', '103', '1', '2025-08-08 13:50:02', null, null, '');
INSERT INTO `sys_menu` VALUES ('11623', '流程分类查询', '11622', '1', '#', '', '', '1', '0', 'F', '0', '0', 'workflow:category:query', '#', '103', '1', '2025-08-08 13:50:02', null, null, '');
INSERT INTO `sys_menu` VALUES ('11624', '流程分类新增', '11622', '2', '#', '', '', '1', '0', 'F', '0', '0', 'workflow:category:add', '#', '103', '1', '2025-08-08 13:50:02', null, null, '');
INSERT INTO `sys_menu` VALUES ('11625', '流程分类修改', '11622', '3', '#', '', '', '1', '0', 'F', '0', '0', 'workflow:category:edit', '#', '103', '1', '2025-08-08 13:50:02', null, null, '');
INSERT INTO `sys_menu` VALUES ('11626', '流程分类删除', '11622', '4', '#', '', '', '1', '0', 'F', '0', '0', 'workflow:category:remove', '#', '103', '1', '2025-08-08 13:50:02', null, null, '');
INSERT INTO `sys_menu` VALUES ('11627', '流程分类导出', '11622', '5', '#', '', '', '1', '0', 'F', '0', '0', 'workflow:category:export', '#', '103', '1', '2025-08-08 13:50:02', null, null, '');
INSERT INTO `sys_menu` VALUES ('11629', '我发起的', '11618', '1', 'myDocument', 'workflow/task/myDocument', '', '1', '1', 'C', '0', '0', '', 'guide', '103', '1', '2025-08-08 13:50:02', null, null, '');
INSERT INTO `sys_menu` VALUES ('11630', '流程监控', '11616', '4', 'monitor', '', '', '1', '0', 'M', '0', '0', '', 'monitor', '103', '1', '2025-08-08 13:50:02', null, null, '');
INSERT INTO `sys_menu` VALUES ('11631', '待办任务', '11630', '2', 'allTaskWaiting', 'workflow/task/allTaskWaiting', '', '1', '1', 'C', '0', '0', '', 'waiting', '103', '1', '2025-08-08 13:50:02', null, null, '');
INSERT INTO `sys_menu` VALUES ('11632', '我的已办', '11618', '3', 'taskFinish', 'workflow/task/taskFinish', '', '1', '1', 'C', '0', '0', '', 'finish', '103', '1', '2025-08-08 13:50:02', null, null, '');
INSERT INTO `sys_menu` VALUES ('11633', '我的抄送', '11618', '4', 'taskCopyList', 'workflow/task/taskCopyList', '', '1', '1', 'C', '0', '0', '', 'my-copy', '103', '1', '2025-08-08 13:50:02', null, null, '');
INSERT INTO `sys_menu` VALUES ('11638', '请假申请', '5', '1', 'leave', 'workflow/leave/index', '', '1', '0', 'C', '0', '0', 'workflow:leave:list', '#', '103', '1', '2025-08-08 13:50:02', null, null, '请假申请菜单');
INSERT INTO `sys_menu` VALUES ('11639', '请假申请查询', '11638', '1', '#', '', '', '1', '0', 'F', '0', '0', 'workflow:leave:query', '#', '103', '1', '2025-08-08 13:50:02', null, null, '');
INSERT INTO `sys_menu` VALUES ('11640', '请假申请新增', '11638', '2', '#', '', '', '1', '0', 'F', '0', '0', 'workflow:leave:add', '#', '103', '1', '2025-08-08 13:50:02', null, null, '');
INSERT INTO `sys_menu` VALUES ('11641', '请假申请修改', '11638', '3', '#', '', '', '1', '0', 'F', '0', '0', 'workflow:leave:edit', '#', '103', '1', '2025-08-08 13:50:02', null, null, '');
INSERT INTO `sys_menu` VALUES ('11642', '请假申请删除', '11638', '4', '#', '', '', '1', '0', 'F', '0', '0', 'workflow:leave:remove', '#', '103', '1', '2025-08-08 13:50:02', null, null, '');
INSERT INTO `sys_menu` VALUES ('11643', '请假申请导出', '11638', '5', '#', '', '', '1', '0', 'F', '0', '0', 'workflow:leave:export', '#', '103', '1', '2025-08-08 13:50:02', null, null, '');
INSERT INTO `sys_menu` VALUES ('11700', '流程设计', '11616', '5', 'design/index', 'workflow/processDefinition/design', '', '1', '1', 'C', '1', '0', 'workflow:leave:edit', '#', '103', '1', '2025-08-08 13:50:02', null, null, '');
INSERT INTO `sys_menu` VALUES ('11701', '请假申请', '11616', '6', 'leaveEdit/index', 'workflow/leave/leaveEdit', '', '1', '1', 'C', '1', '0', 'workflow:leave:edit', '#', '103', '1', '2025-08-08 13:50:02', null, null, '');
INSERT INTO `sys_menu` VALUES ('1954826543377698817', '业务功能', '0', '8', 'businessFunction', null, null, '1', '0', 'M', '0', '0', null, 'category', '103', '1', '2025-08-11 16:45:42', '1', '2025-08-11 16:45:42', '');
INSERT INTO `sys_menu` VALUES ('1954826706762616834', '用户扩展档案', '1954826543377698817', '1', 'userProfile', 'hitUserProfile/userProfile/index', null, '1', '0', 'C', '0', '0', 'hitUserProfile:userProfile:list', '#', '103', '1', '2025-08-11 16:57:32', '1', '2025-08-11 17:00:27', '用户扩展档案菜单');
INSERT INTO `sys_menu` VALUES ('1954826706762616835', '用户扩展档案查询', '1954826706762616834', '1', '#', '', null, '1', '0', 'F', '0', '0', 'hitUserProfile:userProfile:query', '#', '103', '1', '2025-08-11 16:57:32', null, null, '');
INSERT INTO `sys_menu` VALUES ('1954826706762616836', '用户扩展档案新增', '1954826706762616834', '2', '#', '', null, '1', '0', 'F', '0', '0', 'hitUserProfile:userProfile:add', '#', '103', '1', '2025-08-11 16:57:32', null, null, '');
INSERT INTO `sys_menu` VALUES ('1954826706762616837', '用户扩展档案修改', '1954826706762616834', '3', '#', '', null, '1', '0', 'F', '0', '0', 'hitUserProfile:userProfile:edit', '#', '103', '1', '2025-08-11 16:57:32', null, null, '');
INSERT INTO `sys_menu` VALUES ('1954826706762616838', '用户扩展档案删除', '1954826706762616834', '4', '#', '', null, '1', '0', 'F', '0', '0', 'hitUserProfile:userProfile:remove', '#', '103', '1', '2025-08-11 16:57:32', null, null, '');
INSERT INTO `sys_menu` VALUES ('1954826706762616839', '用户扩展档案导出', '1954826706762616834', '5', '#', '', null, '1', '0', 'F', '0', '0', 'hitUserProfile:userProfile:export', '#', '103', '1', '2025-08-11 16:57:32', null, null, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice` (
  `notice_id` bigint NOT NULL COMMENT '公告ID',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `notice_title` varchar(50) NOT NULL COMMENT '公告标题',
  `notice_type` char(1) NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob COMMENT '公告内容',
  `status` char(1) DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='通知公告表';

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES ('1', '000000', '温馨提醒：2018-07-01 新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', '103', '1', '2025-08-08 13:49:43', null, null, '管理员');
INSERT INTO `sys_notice` VALUES ('2', '000000', '维护通知：2018-07-01 系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', '103', '1', '2025-08-08 13:49:43', null, null, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log` (
  `oper_id` bigint NOT NULL COMMENT '日志主键',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `title` varchar(50) DEFAULT '' COMMENT '模块标题',
  `business_type` int DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) DEFAULT '' COMMENT '请求方式',
  `operator_type` int DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(4000) DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(4000) DEFAULT '' COMMENT '返回参数',
  `status` int DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(4000) DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint DEFAULT '0' COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`),
  KEY `idx_sys_oper_log_bt` (`business_type`),
  KEY `idx_sys_oper_log_s` (`status`),
  KEY `idx_sys_oper_log_ot` (`oper_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='操作日志记录';

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES ('1954824877366595585', '000000', '代码生成', '6', 'org.dromara.generator.controller.GenController.importTableSave()', 'POST', '1', 'admin', '研发部门', '/tool/gen/importTable', '0:0:0:0:0:0:0:1', '内网IP', '{\"tables\":\"hit_user_profile\",\"dataName\":\"master\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', '0', '', '2025-08-11 16:39:04', '189');
INSERT INTO `sys_oper_log` VALUES ('1954825467886850050', '000000', '代码生成', '2', 'org.dromara.generator.controller.GenController.editSave()', 'PUT', '1', 'admin', '研发部门', '/tool/gen', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":1,\"updateTime\":\"2025-08-11 16:41:25\",\"params\":{\"treeCode\":null,\"treeName\":null,\"treeParentCode\":null,\"parentMenuId\":null},\"tableId\":\"1954824876720672770\",\"dataName\":\"master\",\"tableName\":\"hit_user_profile\",\"tableComment\":\"用户扩展档案表\",\"subTableName\":null,\"subTableFkName\":null,\"className\":\"HitUserProfile\",\"tplCategory\":\"crud\",\"packageName\":\"org.dromara.hit\",\"moduleName\":\"hitUserProfile\",\"businessName\":\"userProfile\",\"functionName\":\"用户扩展档案\",\"functionAuthor\":\"LKD\",\"genType\":\"0\",\"genPath\":\"/\",\"pkColumn\":null,\"columns\":[{\"createDept\":103,\"createBy\":1,\"createTime\":\"2025-08-11 16:39:04\",\"updateBy\":1,\"updateTime\":\"2025-08-11 16:41:25\",\"columnId\":\"1954824877119131650\",\"tableId\":\"1954824876720672770\",\"columnName\":\"profile_id\",\"columnComment\":\"用户档案ID\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"profileId\",\"isPk\":\"1\",\"isIncrement\":\"1\",\"isRequired\":\"0\",\"isInsert\":null,\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":null,\"queryType\":\"EQ\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":1,\"required\":false,\"list\":true,\"pk\":true,\"superColumn\":false,\"usableColumn\":false,\"edit\":true,\"insert\":false,\"increment\":true,\"query\":false,\"capJavaField\":\"ProfileId\"},{\"createDept\":103,\"createBy\":1,\"createTime\":\"2025-08-11 16:39:04\",\"updateBy\":1,\"updateTime\":\"2025-08-11 16:41:25\",\"columnId\":\"1954824877177851905\",\"tableId\":\"1954824876720672770\",\"columnName\":\"user_id\",\"columnComment\":\"关联用户id\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"userId\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"0\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"queryType\":\"EQ\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":2,\"required\":false,\"list\":true,\"pk\":false,\"superColumn\":false,\"usableColumn\":false,\"edit\":true,\"insert\":true,\"increment\":false,\"query\":true,\"capJavaField\":\"UserId\"},{\"createDept\":103,\"createBy\":1,\"createTime\":\"2025-08-11 16:39:04\",\"updateBy\":1,\"updateTime\":\"2025-08-11 16:41:25\",\"columnId\":\"1954824877177851906\",\"tableId\":\"1954824876720672770\",\"columnName\":\"student_id\",\"columnComment\":\"学号\",\"columnType\":\"varchar(20)\",\"javaType\":\"String\",\"javaField\":\"studentId\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"queryType\":\"EQ\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":3,\"required\":true,\"list\":true,\"pk\":false,\"superColumn\":false,\"usableColumn\":false,\"edit\":true,\"insert\":true,\"increment\":false,\"query\":true,\"capJavaField\":\"StudentId\"},{\"createDept\":103,\"createBy\":1,\"createTime\":\"2025-08-11 16:39:04\",\"updateBy\":1,\"updateTime\":\"2025-08-11 16:41:25\",\"columnId\":\"1954824877177851907\",\"tableId\":\"1954824876720672770\",\"columnName\":\"real_name\",\"columnComment\":\"真实姓名\",\"columnType\":\"varchar(50)\",\"javaType\":\"String\",\"javaField\":\"realName\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"queryType\":\"LIKE\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":4,\"required\":true,\"list\":true,\"pk\":false,\"superColumn\":false,\"usableColumn\":false,\"edit\":true,\"insert\":true,\"increment\":false,\"query\":true,\"capJavaField\":\"RealName\"},{\"createDept\":103,\"createBy\":1,\"createTime\":\"2025-08-11 16:39:04\",\"updateBy\":1,\"updateTime\":\"2025-08-11 16:41:25\",\"columnId\":\"1954824877177851908\",\"tableId\":\"1954824876720672770\",\"columnName\":\"college\",\"columnComment\":\"所属学院\",\"columnType\":\"varchar(100)\",\"javaType\":\"String\",\"javaField\":\"college\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"queryType\":\"EQ\",\"htmlType\":\"select\",\"dictType\":\"hit_college\",\"sort\":5,\"required\":true,\"list\":true,\"pk\":false,\"superColumn\":false,\"usableColumn\":false,\"edit\":true,\"insert\":true,\"increment\":false,\"query\":true,\"capJavaField\":\"College\"},{\"createDept\":103,\"createBy\":1,\"createTime\":\"2025-08-11 16:39:04\",\"updateBy\":1,\"updateTime\":\"2025-08-11 16:41:25\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', '0', '', '2025-08-11 16:41:25', '137');
INSERT INTO `sys_oper_log` VALUES ('1954825556013371394', '000000', '菜单管理', '2', 'org.dromara.system.controller.system.SysMenuController.edit()', 'PUT', '1', 'admin', '研发部门', '/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":103,\"createBy\":null,\"createTime\":\"2025-08-08 13:50:02\",\"updateBy\":null,\"updateTime\":null,\"menuId\":11616,\"parentId\":0,\"menuName\":\"工作流\",\"orderNum\":6,\"path\":\"workflow\",\"component\":\"\",\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"1\",\"perms\":\"\",\"icon\":\"workflow\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', '0', '', '2025-08-11 16:41:46', '19');
INSERT INTO `sys_oper_log` VALUES ('1954825578465480706', '000000', '菜单管理', '2', 'org.dromara.system.controller.system.SysMenuController.edit()', 'PUT', '1', 'admin', '研发部门', '/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":103,\"createBy\":null,\"createTime\":\"2025-08-08 13:50:02\",\"updateBy\":null,\"updateTime\":null,\"menuId\":11618,\"parentId\":0,\"menuName\":\"我的任务\",\"orderNum\":7,\"path\":\"task\",\"component\":\"\",\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"1\",\"perms\":\"\",\"icon\":\"my-task\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', '0', '', '2025-08-11 16:41:51', '22');
INSERT INTO `sys_oper_log` VALUES ('1954825605124476930', '000000', '菜单管理', '2', 'org.dromara.system.controller.system.SysMenuController.edit()', 'PUT', '1', 'admin', '研发部门', '/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":103,\"createBy\":null,\"createTime\":\"2025-08-08 13:49:43\",\"updateBy\":null,\"updateTime\":null,\"menuId\":5,\"parentId\":0,\"menuName\":\"测试菜单\",\"orderNum\":5,\"path\":\"demo\",\"component\":null,\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"1\",\"perms\":\"\",\"icon\":\"star\",\"remark\":\"测试菜单\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', '0', '', '2025-08-11 16:41:58', '21');
INSERT INTO `sys_oper_log` VALUES ('1954825641791082497', '000000', '菜单管理', '3', 'org.dromara.system.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', '研发部门', '/system/menu/4', '0:0:0:0:0:0:0:1', '内网IP', '4', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', '0', '', '2025-08-11 16:42:07', '29');
INSERT INTO `sys_oper_log` VALUES ('1954825670719197185', '000000', '菜单管理', '2', 'org.dromara.system.controller.system.SysMenuController.edit()', 'PUT', '1', 'admin', '研发部门', '/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":103,\"createBy\":null,\"createTime\":\"2025-08-08 13:49:43\",\"updateBy\":null,\"updateTime\":null,\"menuId\":2,\"parentId\":0,\"menuName\":\"系统监控\",\"orderNum\":3,\"path\":\"monitor\",\"component\":null,\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"1\",\"perms\":\"\",\"icon\":\"monitor\",\"remark\":\"系统监控目录\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', '0', '', '2025-08-11 16:42:13', '8');
INSERT INTO `sys_oper_log` VALUES ('1954825694710616066', '000000', '菜单管理', '2', 'org.dromara.system.controller.system.SysMenuController.edit()', 'PUT', '1', 'admin', '研发部门', '/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":103,\"createBy\":null,\"createTime\":\"2025-08-08 13:49:43\",\"updateBy\":null,\"updateTime\":null,\"menuId\":6,\"parentId\":0,\"menuName\":\"租户管理\",\"orderNum\":2,\"path\":\"tenant\",\"component\":null,\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"1\",\"perms\":\"\",\"icon\":\"chart\",\"remark\":\"租户管理目录\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', '0', '', '2025-08-11 16:42:19', '25');
INSERT INTO `sys_oper_log` VALUES ('1954825995274440706', '000000', '个人信息', '2', 'org.dromara.system.controller.system.SysProfileController.updateProfile()', 'PUT', '1', 'admin', '研发部门', '/system/user/profile', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":\"2025-08-08 13:49:43\",\"updateBy\":null,\"updateTime\":null,\"nickName\":\"迪迦\",\"email\":\"770276349@qq.com\",\"phonenumber\":\"18878688656\",\"sex\":\"0\"}', '{\"code\":500,\"msg\":\"修改用户\'admin\'失败，手机号码已存在\",\"data\":null}', '0', '', '2025-08-11 16:43:31', '6');
INSERT INTO `sys_oper_log` VALUES ('1954826034537320450', '000000', '个人信息', '2', 'org.dromara.system.controller.system.SysProfileController.updateProfile()', 'PUT', '1', 'admin', '研发部门', '/system/user/profile', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":\"2025-08-08 13:49:43\",\"updateBy\":null,\"updateTime\":null,\"nickName\":\"迪迦\",\"email\":\"770276349@qq.com\",\"phonenumber\":\"15888888888\",\"sex\":\"0\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', '0', '', '2025-08-11 16:43:40', '43');
INSERT INTO `sys_oper_log` VALUES ('1954826543444807682', '000000', '菜单管理', '1', 'org.dromara.system.controller.system.SysMenuController.add()', 'POST', '1', 'admin', '研发部门', '/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":null,\"parentId\":0,\"menuName\":\"业务功能\",\"orderNum\":8,\"path\":\"businessFunction\",\"component\":null,\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"0\",\"icon\":\"category\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', '0', '', '2025-08-11 16:45:42', '26');
INSERT INTO `sys_oper_log` VALUES ('1954826708444532737', '000000', '代码生成', '8', 'org.dromara.generator.controller.GenController.batchGenCode()', 'GET', '1', 'admin', '研发部门', '/tool/gen/batchGenCode', '0:0:0:0:0:0:0:1', '内网IP', '{\"tableIdStr\":\"1954824876720672770\"}', '', '0', '', '2025-08-11 16:46:21', '401');
INSERT INTO `sys_oper_log` VALUES ('1954830256733548546', '000000', '菜单管理', '2', 'org.dromara.system.controller.system.SysMenuController.edit()', 'PUT', '1', 'admin', '研发部门', '/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":103,\"createBy\":null,\"createTime\":\"2025-08-11 16:57:32\",\"updateBy\":null,\"updateTime\":null,\"menuId\":\"1954826706762616834\",\"parentId\":\"1954826543377698817\",\"menuName\":\"用户扩展档案\",\"orderNum\":1,\"path\":\"userProfile\",\"component\":\"hitUserProfile/userProfile/index\",\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"hitUserProfile:userProfile:list\",\"icon\":\"#\",\"remark\":\"用户扩展档案菜单\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', '0', '', '2025-08-11 17:00:27', '34');

-- ----------------------------
-- Table structure for sys_oss
-- ----------------------------
DROP TABLE IF EXISTS `sys_oss`;
CREATE TABLE `sys_oss` (
  `oss_id` bigint NOT NULL COMMENT '对象存储主键',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `file_name` varchar(255) NOT NULL DEFAULT '' COMMENT '文件名',
  `original_name` varchar(255) NOT NULL DEFAULT '' COMMENT '原名',
  `file_suffix` varchar(10) NOT NULL DEFAULT '' COMMENT '文件后缀名',
  `url` varchar(500) NOT NULL COMMENT 'URL地址',
  `ext1` text COMMENT '扩展字段',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint DEFAULT NULL COMMENT '上传人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  `service` varchar(20) NOT NULL DEFAULT 'minio' COMMENT '服务商',
  PRIMARY KEY (`oss_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='OSS对象存储表';

-- ----------------------------
-- Records of sys_oss
-- ----------------------------

-- ----------------------------
-- Table structure for sys_oss_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_oss_config`;
CREATE TABLE `sys_oss_config` (
  `oss_config_id` bigint NOT NULL COMMENT '主键',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `config_key` varchar(20) NOT NULL DEFAULT '' COMMENT '配置key',
  `access_key` varchar(255) DEFAULT '' COMMENT 'accessKey',
  `secret_key` varchar(255) DEFAULT '' COMMENT '秘钥',
  `bucket_name` varchar(255) DEFAULT '' COMMENT '桶名称',
  `prefix` varchar(255) DEFAULT '' COMMENT '前缀',
  `endpoint` varchar(255) DEFAULT '' COMMENT '访问站点',
  `domain` varchar(255) DEFAULT '' COMMENT '自定义域名',
  `is_https` char(1) DEFAULT 'N' COMMENT '是否https（Y=是,N=否）',
  `region` varchar(255) DEFAULT '' COMMENT '域',
  `access_policy` char(1) NOT NULL DEFAULT '1' COMMENT '桶权限类型(0=private 1=public 2=custom)',
  `status` char(1) DEFAULT '1' COMMENT '是否默认（0=是,1=否）',
  `ext1` varchar(255) DEFAULT '' COMMENT '扩展字段',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`oss_config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='对象存储配置表';

-- ----------------------------
-- Records of sys_oss_config
-- ----------------------------
INSERT INTO `sys_oss_config` VALUES ('1', '000000', 'minio', 'ruoyi', 'ruoyi123', 'ruoyi', '', '127.0.0.1:9000', '', 'N', '', '1', '0', '', '103', '1', '2025-08-08 13:49:43', '1', '2025-08-08 13:49:43', null);
INSERT INTO `sys_oss_config` VALUES ('2', '000000', 'qiniu', 'XXXXXXXXXXXXXXX', 'XXXXXXXXXXXXXXX', 'ruoyi', '', 's3-cn-north-1.qiniucs.com', '', 'N', '', '1', '1', '', '103', '1', '2025-08-08 13:49:43', '1', '2025-08-08 13:49:43', null);
INSERT INTO `sys_oss_config` VALUES ('3', '000000', 'aliyun', 'XXXXXXXXXXXXXXX', 'XXXXXXXXXXXXXXX', 'ruoyi', '', 'oss-cn-beijing.aliyuncs.com', '', 'N', '', '1', '1', '', '103', '1', '2025-08-08 13:49:43', '1', '2025-08-08 13:49:43', null);
INSERT INTO `sys_oss_config` VALUES ('4', '000000', 'qcloud', 'XXXXXXXXXXXXXXX', 'XXXXXXXXXXXXXXX', 'ruoyi-1240000000', '', 'cos.ap-beijing.myqcloud.com', '', 'N', 'ap-beijing', '1', '1', '', '103', '1', '2025-08-08 13:49:43', '1', '2025-08-08 13:49:43', null);
INSERT INTO `sys_oss_config` VALUES ('5', '000000', 'image', 'ruoyi', 'ruoyi123', 'ruoyi', 'image', '127.0.0.1:9000', '', 'N', '', '1', '1', '', '103', '1', '2025-08-08 13:49:43', '1', '2025-08-08 13:49:43', null);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post` (
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `dept_id` bigint NOT NULL COMMENT '部门id',
  `post_code` varchar(64) NOT NULL COMMENT '岗位编码',
  `post_category` varchar(100) DEFAULT NULL COMMENT '岗位类别编码',
  `post_name` varchar(50) NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) NOT NULL COMMENT '状态（0正常 1停用）',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='岗位信息表';

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES ('1', '000000', '103', 'ceo', null, '董事长', '1', '0', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_post` VALUES ('2', '000000', '100', 'se', null, '项目经理', '2', '0', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_post` VALUES ('3', '000000', '100', 'hr', null, '人力资源', '3', '0', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_post` VALUES ('4', '000000', '100', 'user', null, '普通员工', '4', '0', '103', '1', '2025-08-08 13:49:43', null, null, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `role_name` varchar(30) NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限 5：仅本人数据权限 6：部门及以下或本人数据权限）',
  `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) DEFAULT '1' COMMENT '部门树选择项是否关联显示',
  `status` char(1) NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色信息表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '000000', '超级管理员', 'superadmin', '1', '1', '1', '1', '0', '0', '103', '1', '2025-08-08 13:49:43', null, null, '超级管理员');
INSERT INTO `sys_role` VALUES ('3', '000000', '本部门及以下', 'test1', '3', '4', '1', '1', '0', '0', '103', '1', '2025-08-08 13:49:43', null, null, '');
INSERT INTO `sys_role` VALUES ('4', '000000', '仅本人', 'test2', '4', '5', '1', '1', '0', '0', '103', '1', '2025-08-08 13:49:43', null, null, '');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色和部门关联表';

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色和菜单关联表';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('3', '1');
INSERT INTO `sys_role_menu` VALUES ('3', '5');
INSERT INTO `sys_role_menu` VALUES ('3', '100');
INSERT INTO `sys_role_menu` VALUES ('3', '101');
INSERT INTO `sys_role_menu` VALUES ('3', '102');
INSERT INTO `sys_role_menu` VALUES ('3', '103');
INSERT INTO `sys_role_menu` VALUES ('3', '104');
INSERT INTO `sys_role_menu` VALUES ('3', '105');
INSERT INTO `sys_role_menu` VALUES ('3', '106');
INSERT INTO `sys_role_menu` VALUES ('3', '107');
INSERT INTO `sys_role_menu` VALUES ('3', '108');
INSERT INTO `sys_role_menu` VALUES ('3', '118');
INSERT INTO `sys_role_menu` VALUES ('3', '123');
INSERT INTO `sys_role_menu` VALUES ('3', '130');
INSERT INTO `sys_role_menu` VALUES ('3', '131');
INSERT INTO `sys_role_menu` VALUES ('3', '132');
INSERT INTO `sys_role_menu` VALUES ('3', '133');
INSERT INTO `sys_role_menu` VALUES ('3', '500');
INSERT INTO `sys_role_menu` VALUES ('3', '501');
INSERT INTO `sys_role_menu` VALUES ('3', '1001');
INSERT INTO `sys_role_menu` VALUES ('3', '1002');
INSERT INTO `sys_role_menu` VALUES ('3', '1003');
INSERT INTO `sys_role_menu` VALUES ('3', '1004');
INSERT INTO `sys_role_menu` VALUES ('3', '1005');
INSERT INTO `sys_role_menu` VALUES ('3', '1006');
INSERT INTO `sys_role_menu` VALUES ('3', '1007');
INSERT INTO `sys_role_menu` VALUES ('3', '1008');
INSERT INTO `sys_role_menu` VALUES ('3', '1009');
INSERT INTO `sys_role_menu` VALUES ('3', '1010');
INSERT INTO `sys_role_menu` VALUES ('3', '1011');
INSERT INTO `sys_role_menu` VALUES ('3', '1012');
INSERT INTO `sys_role_menu` VALUES ('3', '1013');
INSERT INTO `sys_role_menu` VALUES ('3', '1014');
INSERT INTO `sys_role_menu` VALUES ('3', '1015');
INSERT INTO `sys_role_menu` VALUES ('3', '1016');
INSERT INTO `sys_role_menu` VALUES ('3', '1017');
INSERT INTO `sys_role_menu` VALUES ('3', '1018');
INSERT INTO `sys_role_menu` VALUES ('3', '1019');
INSERT INTO `sys_role_menu` VALUES ('3', '1020');
INSERT INTO `sys_role_menu` VALUES ('3', '1021');
INSERT INTO `sys_role_menu` VALUES ('3', '1022');
INSERT INTO `sys_role_menu` VALUES ('3', '1023');
INSERT INTO `sys_role_menu` VALUES ('3', '1024');
INSERT INTO `sys_role_menu` VALUES ('3', '1025');
INSERT INTO `sys_role_menu` VALUES ('3', '1026');
INSERT INTO `sys_role_menu` VALUES ('3', '1027');
INSERT INTO `sys_role_menu` VALUES ('3', '1028');
INSERT INTO `sys_role_menu` VALUES ('3', '1029');
INSERT INTO `sys_role_menu` VALUES ('3', '1030');
INSERT INTO `sys_role_menu` VALUES ('3', '1031');
INSERT INTO `sys_role_menu` VALUES ('3', '1032');
INSERT INTO `sys_role_menu` VALUES ('3', '1033');
INSERT INTO `sys_role_menu` VALUES ('3', '1034');
INSERT INTO `sys_role_menu` VALUES ('3', '1035');
INSERT INTO `sys_role_menu` VALUES ('3', '1036');
INSERT INTO `sys_role_menu` VALUES ('3', '1037');
INSERT INTO `sys_role_menu` VALUES ('3', '1038');
INSERT INTO `sys_role_menu` VALUES ('3', '1039');
INSERT INTO `sys_role_menu` VALUES ('3', '1040');
INSERT INTO `sys_role_menu` VALUES ('3', '1041');
INSERT INTO `sys_role_menu` VALUES ('3', '1042');
INSERT INTO `sys_role_menu` VALUES ('3', '1043');
INSERT INTO `sys_role_menu` VALUES ('3', '1044');
INSERT INTO `sys_role_menu` VALUES ('3', '1045');
INSERT INTO `sys_role_menu` VALUES ('3', '1050');
INSERT INTO `sys_role_menu` VALUES ('3', '1061');
INSERT INTO `sys_role_menu` VALUES ('3', '1062');
INSERT INTO `sys_role_menu` VALUES ('3', '1063');
INSERT INTO `sys_role_menu` VALUES ('3', '1064');
INSERT INTO `sys_role_menu` VALUES ('3', '1065');
INSERT INTO `sys_role_menu` VALUES ('3', '1500');
INSERT INTO `sys_role_menu` VALUES ('3', '1501');
INSERT INTO `sys_role_menu` VALUES ('3', '1502');
INSERT INTO `sys_role_menu` VALUES ('3', '1503');
INSERT INTO `sys_role_menu` VALUES ('3', '1504');
INSERT INTO `sys_role_menu` VALUES ('3', '1505');
INSERT INTO `sys_role_menu` VALUES ('3', '1506');
INSERT INTO `sys_role_menu` VALUES ('3', '1507');
INSERT INTO `sys_role_menu` VALUES ('3', '1508');
INSERT INTO `sys_role_menu` VALUES ('3', '1509');
INSERT INTO `sys_role_menu` VALUES ('3', '1510');
INSERT INTO `sys_role_menu` VALUES ('3', '1511');
INSERT INTO `sys_role_menu` VALUES ('3', '1600');
INSERT INTO `sys_role_menu` VALUES ('3', '1601');
INSERT INTO `sys_role_menu` VALUES ('3', '1602');
INSERT INTO `sys_role_menu` VALUES ('3', '1603');
INSERT INTO `sys_role_menu` VALUES ('3', '1620');
INSERT INTO `sys_role_menu` VALUES ('3', '1621');
INSERT INTO `sys_role_menu` VALUES ('3', '1622');
INSERT INTO `sys_role_menu` VALUES ('3', '1623');
INSERT INTO `sys_role_menu` VALUES ('3', '11616');
INSERT INTO `sys_role_menu` VALUES ('3', '11618');
INSERT INTO `sys_role_menu` VALUES ('3', '11619');
INSERT INTO `sys_role_menu` VALUES ('3', '11622');
INSERT INTO `sys_role_menu` VALUES ('3', '11623');
INSERT INTO `sys_role_menu` VALUES ('3', '11629');
INSERT INTO `sys_role_menu` VALUES ('3', '11632');
INSERT INTO `sys_role_menu` VALUES ('3', '11633');
INSERT INTO `sys_role_menu` VALUES ('3', '11638');
INSERT INTO `sys_role_menu` VALUES ('3', '11639');
INSERT INTO `sys_role_menu` VALUES ('3', '11640');
INSERT INTO `sys_role_menu` VALUES ('3', '11641');
INSERT INTO `sys_role_menu` VALUES ('3', '11642');
INSERT INTO `sys_role_menu` VALUES ('3', '11643');
INSERT INTO `sys_role_menu` VALUES ('3', '11701');
INSERT INTO `sys_role_menu` VALUES ('4', '5');
INSERT INTO `sys_role_menu` VALUES ('4', '1500');
INSERT INTO `sys_role_menu` VALUES ('4', '1501');
INSERT INTO `sys_role_menu` VALUES ('4', '1502');
INSERT INTO `sys_role_menu` VALUES ('4', '1503');
INSERT INTO `sys_role_menu` VALUES ('4', '1504');
INSERT INTO `sys_role_menu` VALUES ('4', '1505');
INSERT INTO `sys_role_menu` VALUES ('4', '1506');
INSERT INTO `sys_role_menu` VALUES ('4', '1507');
INSERT INTO `sys_role_menu` VALUES ('4', '1508');
INSERT INTO `sys_role_menu` VALUES ('4', '1509');
INSERT INTO `sys_role_menu` VALUES ('4', '1510');
INSERT INTO `sys_role_menu` VALUES ('4', '1511');

-- ----------------------------
-- Table structure for sys_social
-- ----------------------------
DROP TABLE IF EXISTS `sys_social`;
CREATE TABLE `sys_social` (
  `id` bigint NOT NULL COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户id',
  `auth_id` varchar(255) NOT NULL COMMENT '平台+平台唯一id',
  `source` varchar(255) NOT NULL COMMENT '用户来源',
  `open_id` varchar(255) DEFAULT NULL COMMENT '平台编号唯一id',
  `user_name` varchar(30) NOT NULL COMMENT '登录账号',
  `nick_name` varchar(30) DEFAULT '' COMMENT '用户昵称',
  `email` varchar(255) DEFAULT '' COMMENT '用户邮箱',
  `avatar` varchar(500) DEFAULT '' COMMENT '头像地址',
  `access_token` varchar(2000) NOT NULL COMMENT '用户的授权令牌',
  `expire_in` int DEFAULT NULL COMMENT '用户的授权令牌的有效期，部分平台可能没有',
  `refresh_token` varchar(255) DEFAULT NULL COMMENT '刷新令牌，部分平台可能没有',
  `access_code` varchar(2000) DEFAULT NULL COMMENT '平台的授权信息，部分平台可能没有',
  `union_id` varchar(255) DEFAULT NULL COMMENT '用户的 unionid',
  `scope` varchar(255) DEFAULT NULL COMMENT '授予的权限，部分平台可能没有',
  `token_type` varchar(255) DEFAULT NULL COMMENT '个别平台的授权信息，部分平台可能没有',
  `id_token` varchar(2000) DEFAULT NULL COMMENT 'id token，部分平台可能没有',
  `mac_algorithm` varchar(255) DEFAULT NULL COMMENT '小米平台用户的附带属性，部分平台可能没有',
  `mac_key` varchar(255) DEFAULT NULL COMMENT '小米平台用户的附带属性，部分平台可能没有',
  `code` varchar(255) DEFAULT NULL COMMENT '用户的授权code，部分平台可能没有',
  `oauth_token` varchar(255) DEFAULT NULL COMMENT 'Twitter平台用户的附带属性，部分平台可能没有',
  `oauth_token_secret` varchar(255) DEFAULT NULL COMMENT 'Twitter平台用户的附带属性，部分平台可能没有',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='社会化关系表';

-- ----------------------------
-- Records of sys_social
-- ----------------------------
INSERT INTO `sys_social` VALUES ('1953827752140673026', '1953827752052592642', '000000', 'wechat_miniprogram_oIT4b6ZpkeWZemXbLzx-6J_1MChY', 'wechat_miniprogram', 'oIT4b6ZpkeWZemXbLzx-6J_1MChY', '', '', '', '', 'Zkd5z//suedM92WB3/EpLw==', '0', null, null, null, null, null, null, null, null, null, null, null, '-1', '-1', '2025-08-08 22:36:51', '-1', '2025-08-08 22:36:51', '0');

-- ----------------------------
-- Table structure for sys_tenant
-- ----------------------------
DROP TABLE IF EXISTS `sys_tenant`;
CREATE TABLE `sys_tenant` (
  `id` bigint NOT NULL COMMENT 'id',
  `tenant_id` varchar(20) NOT NULL COMMENT '租户编号',
  `contact_user_name` varchar(20) DEFAULT NULL COMMENT '联系人',
  `contact_phone` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `company_name` varchar(30) DEFAULT NULL COMMENT '企业名称',
  `license_number` varchar(30) DEFAULT NULL COMMENT '统一社会信用代码',
  `address` varchar(200) DEFAULT NULL COMMENT '地址',
  `intro` varchar(200) DEFAULT NULL COMMENT '企业简介',
  `domain` varchar(200) DEFAULT NULL COMMENT '域名',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `package_id` bigint DEFAULT NULL COMMENT '租户套餐编号',
  `expire_time` datetime DEFAULT NULL COMMENT '过期时间',
  `account_count` int DEFAULT '-1' COMMENT '用户数量（-1不限制）',
  `status` char(1) DEFAULT '0' COMMENT '租户状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='租户表';

-- ----------------------------
-- Records of sys_tenant
-- ----------------------------
INSERT INTO `sys_tenant` VALUES ('1', '000000', '管理组', '15888888888', 'XXX有限公司', null, null, '多租户通用后台管理管理系统', null, null, null, null, '-1', '0', '0', '103', '1', '2025-08-08 13:49:43', null, null);

-- ----------------------------
-- Table structure for sys_tenant_package
-- ----------------------------
DROP TABLE IF EXISTS `sys_tenant_package`;
CREATE TABLE `sys_tenant_package` (
  `package_id` bigint NOT NULL COMMENT '租户套餐id',
  `package_name` varchar(20) DEFAULT NULL COMMENT '套餐名称',
  `menu_ids` varchar(3000) DEFAULT NULL COMMENT '关联菜单id',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`package_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='租户套餐表';

-- ----------------------------
-- Records of sys_tenant_package
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `dept_id` bigint DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) NOT NULL COMMENT '用户昵称',
  `user_type` varchar(10) DEFAULT 'sys_user' COMMENT '用户类型（sys_user系统用户）',
  `email` varchar(50) DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) DEFAULT '' COMMENT '手机号码',
  `sex` char(1) DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` bigint DEFAULT NULL COMMENT '头像地址',
  `password` varchar(100) DEFAULT '' COMMENT '密码',
  `status` char(1) DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `login_ip` varchar(128) DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户信息表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', '000000', '103', 'admin', '迪迦', 'sys_user', '770276349@qq.com', '15888888888', '0', null, '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '0:0:0:0:0:0:0:1', '2025-08-11 16:19:19', '103', '1', '2025-08-08 13:49:43', '-1', '2025-08-11 16:19:19', '管理员');
INSERT INTO `sys_user` VALUES ('3', '000000', '108', 'test', '本部门及以下 密码666666', 'sys_user', '', '', '0', null, '$2a$10$b8yUzN0C71sbz.PhNOCgJe.Tu1yWC3RNrTyjSQ8p1W0.aaUXUJ.Ne', '0', '0', '127.0.0.1', '2025-08-08 13:49:43', '103', '1', '2025-08-08 13:49:43', '3', '2025-08-08 13:49:43', null);
INSERT INTO `sys_user` VALUES ('4', '000000', '102', 'test1', '仅本人 密码666666', 'sys_user', '', '', '0', null, '$2a$10$b8yUzN0C71sbz.PhNOCgJe.Tu1yWC3RNrTyjSQ8p1W0.aaUXUJ.Ne', '0', '0', '127.0.0.1', '2025-08-08 13:49:43', '103', '1', '2025-08-08 13:49:43', '4', '2025-08-08 13:49:43', null);
INSERT INTO `sys_user` VALUES ('1953827752052592642', '000000', null, '18878688656', '用户863a0d', 'app_user', '', '18878688656', '0', null, '$2a$10$cH1XMJb4gN/GCy1EQDvLaefPyMhnRC0b66fLMUDOicl1fbkQNJUrq', '0', '0', '0:0:0:0:0:0:0:1', '2025-08-08 22:36:51', '-1', '-1', '2025-08-08 22:36:51', '-1', '2025-08-08 22:36:51', null);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户与岗位关联表';

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES ('1', '1');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户和角色关联表';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('1', '1');
INSERT INTO `sys_user_role` VALUES ('3', '3');
INSERT INTO `sys_user_role` VALUES ('4', '4');

-- ----------------------------
-- Table structure for test_demo
-- ----------------------------
DROP TABLE IF EXISTS `test_demo`;
CREATE TABLE `test_demo` (
  `id` bigint NOT NULL COMMENT '主键',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `dept_id` bigint DEFAULT NULL COMMENT '部门id',
  `user_id` bigint DEFAULT NULL COMMENT '用户id',
  `order_num` int DEFAULT '0' COMMENT '排序号',
  `test_key` varchar(255) DEFAULT NULL COMMENT 'key键',
  `value` varchar(255) DEFAULT NULL COMMENT '值',
  `version` int DEFAULT '0' COMMENT '版本',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  `del_flag` int DEFAULT '0' COMMENT '删除标志',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='测试单表';

-- ----------------------------
-- Records of test_demo
-- ----------------------------
INSERT INTO `test_demo` VALUES ('1', '000000', '102', '4', '1', '测试数据权限', '测试', '0', '103', '2025-08-08 13:49:44', '1', null, null, '0');
INSERT INTO `test_demo` VALUES ('2', '000000', '102', '3', '2', '子节点1', '111', '0', '103', '2025-08-08 13:49:44', '1', null, null, '0');
INSERT INTO `test_demo` VALUES ('3', '000000', '102', '3', '3', '子节点2', '222', '0', '103', '2025-08-08 13:49:44', '1', null, null, '0');
INSERT INTO `test_demo` VALUES ('4', '000000', '108', '4', '4', '测试数据', 'demo', '0', '103', '2025-08-08 13:49:44', '1', null, null, '0');
INSERT INTO `test_demo` VALUES ('5', '000000', '108', '3', '13', '子节点11', '1111', '0', '103', '2025-08-08 13:49:44', '1', null, null, '0');
INSERT INTO `test_demo` VALUES ('6', '000000', '108', '3', '12', '子节点22', '2222', '0', '103', '2025-08-08 13:49:44', '1', null, null, '0');
INSERT INTO `test_demo` VALUES ('7', '000000', '108', '3', '11', '子节点33', '3333', '0', '103', '2025-08-08 13:49:44', '1', null, null, '0');
INSERT INTO `test_demo` VALUES ('8', '000000', '108', '3', '10', '子节点44', '4444', '0', '103', '2025-08-08 13:49:44', '1', null, null, '0');
INSERT INTO `test_demo` VALUES ('9', '000000', '108', '3', '9', '子节点55', '5555', '0', '103', '2025-08-08 13:49:44', '1', null, null, '0');
INSERT INTO `test_demo` VALUES ('10', '000000', '108', '3', '8', '子节点66', '6666', '0', '103', '2025-08-08 13:49:44', '1', null, null, '0');
INSERT INTO `test_demo` VALUES ('11', '000000', '108', '3', '7', '子节点77', '7777', '0', '103', '2025-08-08 13:49:44', '1', null, null, '0');
INSERT INTO `test_demo` VALUES ('12', '000000', '108', '3', '6', '子节点88', '8888', '0', '103', '2025-08-08 13:49:44', '1', null, null, '0');
INSERT INTO `test_demo` VALUES ('13', '000000', '108', '3', '5', '子节点99', '9999', '0', '103', '2025-08-08 13:49:44', '1', null, null, '0');

-- ----------------------------
-- Table structure for test_leave
-- ----------------------------
DROP TABLE IF EXISTS `test_leave`;
CREATE TABLE `test_leave` (
  `id` bigint NOT NULL COMMENT 'id',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `leave_type` varchar(255) NOT NULL COMMENT '请假类型',
  `start_date` datetime NOT NULL COMMENT '开始时间',
  `end_date` datetime NOT NULL COMMENT '结束时间',
  `leave_days` int NOT NULL COMMENT '请假天数',
  `remark` varchar(255) DEFAULT NULL COMMENT '请假原因',
  `status` varchar(255) DEFAULT NULL COMMENT '状态',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='请假申请表';

-- ----------------------------
-- Records of test_leave
-- ----------------------------

-- ----------------------------
-- Table structure for test_tree
-- ----------------------------
DROP TABLE IF EXISTS `test_tree`;
CREATE TABLE `test_tree` (
  `id` bigint NOT NULL COMMENT '主键',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `parent_id` bigint DEFAULT '0' COMMENT '父id',
  `dept_id` bigint DEFAULT NULL COMMENT '部门id',
  `user_id` bigint DEFAULT NULL COMMENT '用户id',
  `tree_name` varchar(255) DEFAULT NULL COMMENT '值',
  `version` int DEFAULT '0' COMMENT '版本',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  `del_flag` int DEFAULT '0' COMMENT '删除标志',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='测试树表';

-- ----------------------------
-- Records of test_tree
-- ----------------------------
INSERT INTO `test_tree` VALUES ('1', '000000', '0', '102', '4', '测试数据权限', '0', '103', '2025-08-08 13:49:44', '1', null, null, '0');
INSERT INTO `test_tree` VALUES ('2', '000000', '1', '102', '3', '子节点1', '0', '103', '2025-08-08 13:49:44', '1', null, null, '0');
INSERT INTO `test_tree` VALUES ('3', '000000', '2', '102', '3', '子节点2', '0', '103', '2025-08-08 13:49:44', '1', null, null, '0');
INSERT INTO `test_tree` VALUES ('4', '000000', '0', '108', '4', '测试树1', '0', '103', '2025-08-08 13:49:44', '1', null, null, '0');
INSERT INTO `test_tree` VALUES ('5', '000000', '4', '108', '3', '子节点11', '0', '103', '2025-08-08 13:49:44', '1', null, null, '0');
INSERT INTO `test_tree` VALUES ('6', '000000', '4', '108', '3', '子节点22', '0', '103', '2025-08-08 13:49:44', '1', null, null, '0');
INSERT INTO `test_tree` VALUES ('7', '000000', '4', '108', '3', '子节点33', '0', '103', '2025-08-08 13:49:44', '1', null, null, '0');
INSERT INTO `test_tree` VALUES ('8', '000000', '5', '108', '3', '子节点44', '0', '103', '2025-08-08 13:49:44', '1', null, null, '0');
INSERT INTO `test_tree` VALUES ('9', '000000', '6', '108', '3', '子节点55', '0', '103', '2025-08-08 13:49:44', '1', null, null, '0');
INSERT INTO `test_tree` VALUES ('10', '000000', '7', '108', '3', '子节点66', '0', '103', '2025-08-08 13:49:44', '1', null, null, '0');
INSERT INTO `test_tree` VALUES ('11', '000000', '7', '108', '3', '子节点77', '0', '103', '2025-08-08 13:49:44', '1', null, null, '0');
INSERT INTO `test_tree` VALUES ('12', '000000', '10', '108', '3', '子节点88', '0', '103', '2025-08-08 13:49:44', '1', null, null, '0');
INSERT INTO `test_tree` VALUES ('13', '000000', '10', '108', '3', '子节点99', '0', '103', '2025-08-08 13:49:44', '1', null, null, '0');
