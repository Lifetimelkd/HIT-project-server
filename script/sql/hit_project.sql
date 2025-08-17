/*
 Navicat Premium Dump SQL

 Source Server         : 123.56.113.24
 Source Server Type    : MySQL
 Source Server Version : 80031 (8.0.31)
 Source Host           : 123.56.113.24:3307
 Source Schema         : hit_project

 Target Server Type    : MySQL
 Target Server Version : 80031 (8.0.31)
 File Encoding         : 65001

 Date: 16/08/2025 12:38:34
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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
BEGIN;
INSERT INTO `flow_category` (`category_id`, `tenant_id`, `parent_id`, `ancestors`, `category_name`, `order_num`, `del_flag`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (100, '000000', 0, '0', 'OA审批', 0, '0', 103, 1, '2025-08-08 13:50:02', NULL, NULL);
INSERT INTO `flow_category` (`category_id`, `tenant_id`, `parent_id`, `ancestors`, `category_name`, `order_num`, `del_flag`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (101, '000000', 100, '0,100', '假勤管理', 0, '0', 103, 1, '2025-08-08 13:50:02', NULL, NULL);
INSERT INTO `flow_category` (`category_id`, `tenant_id`, `parent_id`, `ancestors`, `category_name`, `order_num`, `del_flag`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (102, '000000', 100, '0,100', '人事管理', 1, '0', 103, 1, '2025-08-08 13:50:02', NULL, NULL);
INSERT INTO `flow_category` (`category_id`, `tenant_id`, `parent_id`, `ancestors`, `category_name`, `order_num`, `del_flag`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (103, '000000', 101, '0,100,101', '请假', 0, '0', 103, 1, '2025-08-08 13:50:02', NULL, NULL);
INSERT INTO `flow_category` (`category_id`, `tenant_id`, `parent_id`, `ancestors`, `category_name`, `order_num`, `del_flag`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (104, '000000', 101, '0,100,101', '出差', 1, '0', 103, 1, '2025-08-08 13:50:02', NULL, NULL);
INSERT INTO `flow_category` (`category_id`, `tenant_id`, `parent_id`, `ancestors`, `category_name`, `order_num`, `del_flag`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (105, '000000', 101, '0,100,101', '加班', 2, '0', 103, 1, '2025-08-08 13:50:02', NULL, NULL);
INSERT INTO `flow_category` (`category_id`, `tenant_id`, `parent_id`, `ancestors`, `category_name`, `order_num`, `del_flag`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (106, '000000', 101, '0,100,101', '换班', 3, '0', 103, 1, '2025-08-08 13:50:02', NULL, NULL);
INSERT INTO `flow_category` (`category_id`, `tenant_id`, `parent_id`, `ancestors`, `category_name`, `order_num`, `del_flag`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (107, '000000', 101, '0,100,101', '外出', 4, '0', 103, 1, '2025-08-08 13:50:02', NULL, NULL);
INSERT INTO `flow_category` (`category_id`, `tenant_id`, `parent_id`, `ancestors`, `category_name`, `order_num`, `del_flag`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (108, '000000', 102, '0,100,102', '转正', 1, '0', 103, 1, '2025-08-08 13:50:02', NULL, NULL);
INSERT INTO `flow_category` (`category_id`, `tenant_id`, `parent_id`, `ancestors`, `category_name`, `order_num`, `del_flag`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (109, '000000', 102, '0,100,102', '离职', 2, '0', 103, 1, '2025-08-08 13:50:02', NULL, NULL);
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
INSERT INTO `gen_table` (`table_id`, `data_name`, `table_name`, `table_comment`, `sub_table_name`, `sub_table_fk_name`, `class_name`, `tpl_category`, `package_name`, `module_name`, `business_name`, `function_name`, `function_author`, `gen_type`, `gen_path`, `options`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1954824876720672770, 'master', 'hit_user_profile', '用户扩展档案表', NULL, NULL, 'HitUserProfile', 'crud', 'org.dromara.hit', 'hitUserProfile', 'userProfile', '用户扩展档案', 'LKD', '0', '/', '{\"treeCode\":null,\"treeName\":null,\"treeParentCode\":null,\"parentMenuId\":null}', 103, 1, '2025-08-11 16:39:04', 1, '2025-08-11 16:41:25', NULL);
COMMIT;

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
BEGIN;
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1954824877119131650, 1954824876720672770, 'profile_id', '用户档案ID', 'bigint', 'Long', 'profileId', '1', '1', '0', NULL, '1', '1', NULL, 'EQ', 'input', '', 1, 103, 1, '2025-08-11 16:39:04', 1, '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1954824877177851905, 1954824876720672770, 'user_id', '关联用户id', 'bigint', 'Long', 'userId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 2, 103, 1, '2025-08-11 16:39:04', 1, '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1954824877177851906, 1954824876720672770, 'student_id', '学号', 'varchar(20)', 'String', 'studentId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 103, 1, '2025-08-11 16:39:04', 1, '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1954824877177851907, 1954824876720672770, 'real_name', '真实姓名', 'varchar(50)', 'String', 'realName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 4, 103, 1, '2025-08-11 16:39:04', 1, '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1954824877177851908, 1954824876720672770, 'college', '所属学院', 'varchar(100)', 'String', 'college', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'hit_college', 5, 103, 1, '2025-08-11 16:39:04', 1, '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1954824877177851909, 1954824876720672770, 'major', '专业', 'varchar(100)', 'String', 'major', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 6, 103, 1, '2025-08-11 16:39:04', 1, '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1954824877177851910, 1954824876720672770, 'grade', '年级', 'varchar(20)', 'String', 'grade', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'hit_grade', 7, 103, 1, '2025-08-11 16:39:04', 1, '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1954824877177851911, 1954824876720672770, 'class_name', '班级', 'varchar(50)', 'String', 'className', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 8, 103, 1, '2025-08-11 16:39:04', 1, '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1954824877177851912, 1954824876720672770, 'phone', '手机号', 'varchar(20)', 'String', 'phone', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 9, 103, 1, '2025-08-11 16:39:04', 1, '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1954824877177851913, 1954824876720672770, 'email', '邮箱', 'varchar(100)', 'String', 'email', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 10, 103, 1, '2025-08-11 16:39:04', 1, '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1954824877177851914, 1954824876720672770, 'qq', 'QQ号', 'varchar(20)', 'String', 'qq', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 11, 103, 1, '2025-08-11 16:39:04', 1, '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1954824877177851915, 1954824876720672770, 'wechat', '微信号', 'varchar(50)', 'String', 'wechat', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 12, 103, 1, '2025-08-11 16:39:04', 1, '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1954824877177851916, 1954824876720672770, 'github', 'GitHub地址', 'varchar(100)', 'String', 'github', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 13, 103, 1, '2025-08-11 16:39:04', 1, '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1954824877177851917, 1954824876720672770, 'linkedin', 'LinkedIn地址', 'varchar(100)', 'String', 'linkedin', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 14, 103, 1, '2025-08-11 16:39:04', 1, '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1954824877177851918, 1954824876720672770, 'personal_intro', '个人简介', 'text', 'String', 'personalIntro', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'textarea', '', 15, 103, 1, '2025-08-11 16:39:04', 1, '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1954824877177851919, 1954824876720672770, 'career_plan', '职业规划', 'text', 'String', 'careerPlan', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'textarea', '', 16, 103, 1, '2025-08-11 16:39:04', 1, '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1954824877177851920, 1954824876720672770, 'avatar_url', '头像地址', 'varchar(500)', 'String', 'avatarUrl', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'textarea', '', 17, 103, 1, '2025-08-11 16:39:04', 1, '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1954824877177851921, 1954824876720672770, 'cover_url', '封面地址', 'varchar(500)', 'String', 'coverUrl', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'textarea', '', 18, 103, 1, '2025-08-11 16:39:04', 1, '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1954824877240766466, 1954824876720672770, 'reputation_score', '信誉积分', 'decimal(5,2)', 'Long', 'reputationScore', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 19, 103, 1, '2025-08-11 16:39:04', 1, '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1954824877240766467, 1954824876720672770, 'total_projects', '参与项目总数', 'int', 'Long', 'totalProjects', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 20, 103, 1, '2025-08-11 16:39:04', 1, '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1954824877240766468, 1954824876720672770, 'completed_projects', '完成项目数', 'int', 'Long', 'completedProjects', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 21, 103, 1, '2025-08-11 16:39:04', 1, '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1954824877240766469, 1954824876720672770, 'status', '状态(0正常 1禁用)', 'char(1)', 'String', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', 22, 103, 1, '2025-08-11 16:39:04', 1, '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1954824877240766470, 1954824876720672770, 'tenant_id', '租户ID', 'varchar(20)', 'String', 'tenantId', '0', '0', '1', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 23, 103, 1, '2025-08-11 16:39:04', 1, '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1954824877240766471, 1954824876720672770, 'create_dept', '创建部门', 'bigint', 'Long', 'createDept', '0', '0', '1', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 24, 103, 1, '2025-08-11 16:39:04', 1, '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1954824877240766472, 1954824876720672770, 'create_by', '创建者', 'bigint', 'Long', 'createBy', '0', '0', '1', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 25, 103, 1, '2025-08-11 16:39:04', 1, '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1954824877240766473, 1954824876720672770, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '1', NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 26, 103, 1, '2025-08-11 16:39:04', 1, '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1954824877240766474, 1954824876720672770, 'update_by', '更新者', 'bigint', 'Long', 'updateBy', '0', '0', '1', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 27, 103, 1, '2025-08-11 16:39:04', 1, '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1954824877240766475, 1954824876720672770, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '1', NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 28, 103, 1, '2025-08-11 16:39:04', 1, '2025-08-11 16:41:25');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1954824877240766476, 1954824876720672770, 'dept_id', '关联部门id', 'bigint', 'Long', 'deptId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 29, 103, 1, '2025-08-11 16:39:04', 1, '2025-08-11 16:41:25');
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
INSERT INTO `hit_platform_config` (`config_id`, `config_key`, `config_value`, `config_type`, `config_group`, `config_description`, `is_system`, `is_encrypted`, `sort_order`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (1, 'max_project_members', '20', 'number', 'project', '项目最大成员数限制', '1', '0', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
INSERT INTO `hit_platform_config` (`config_id`, `config_key`, `config_value`, `config_type`, `config_group`, `config_description`, `is_system`, `is_encrypted`, `sort_order`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (2, 'application_review_days', '7', 'number', 'project', '项目申请审核期限(天)', '1', '0', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
INSERT INTO `hit_platform_config` (`config_id`, `config_key`, `config_value`, `config_type`, `config_group`, `config_description`, `is_system`, `is_encrypted`, `sort_order`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (3, 'mentor_max_projects', '10', 'number', 'mentor', '导师最大指导项目数', '1', '0', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
INSERT INTO `hit_platform_config` (`config_id`, `config_key`, `config_value`, `config_type`, `config_group`, `config_description`, `is_system`, `is_encrypted`, `sort_order`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (4, 'notification_retention_days', '30', 'number', 'notification', '通知保留天数', '1', '0', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
INSERT INTO `hit_platform_config` (`config_id`, `config_key`, `config_value`, `config_type`, `config_group`, `config_description`, `is_system`, `is_encrypted`, `sort_order`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (5, 'user_reputation_initial', '100', 'number', 'user', '用户初始信誉分', '1', '0', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
INSERT INTO `hit_platform_config` (`config_id`, `config_key`, `config_value`, `config_type`, `config_group`, `config_description`, `is_system`, `is_encrypted`, `sort_order`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (6, 'project_featured_count', '10', 'number', 'project', '首页精选项目数量', '1', '0', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
INSERT INTO `hit_platform_config` (`config_id`, `config_key`, `config_value`, `config_type`, `config_group`, `config_description`, `is_system`, `is_encrypted`, `sort_order`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (7, 'enable_auto_match', 'true', 'boolean', 'system', '是否启用智能匹配', '1', '0', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
INSERT INTO `hit_platform_config` (`config_id`, `config_key`, `config_value`, `config_type`, `config_group`, `config_description`, `is_system`, `is_encrypted`, `sort_order`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (8, 'platform_announcement', '欢迎使用HIT项目组队通！', 'string', 'system', '平台公告', '0', '0', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
COMMIT;

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
) ENGINE=InnoDB AUTO_INCREMENT=1955984161988997123 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='项目信息表';

-- ----------------------------
-- Records of hit_project
-- ----------------------------
BEGIN;
INSERT INTO `hit_project` (`project_id`, `project_name`, `project_description`, `project_background`, `project_goals`, `expected_outcome`, `cover_image`, `project_type`, `project_category`, `difficulty_level`, `duration_type`, `start_date`, `end_date`, `team_size_min`, `team_size_max`, `current_members`, `status`, `recruitment_status`, `visibility`, `approval_mode`, `view_count`, `like_count`, `collect_count`, `apply_count`, `is_featured`, `is_urgent`, `is_credit`, `creator_id`, `mentor_id`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (1, '智慧校园移动应用开发', '基于Vue3和Spring Boot开发的智慧校园移动应用，包含学生信息管理、课程安排、成绩查询等功能。', '随着移动互联网的发展，传统的校园管理系统已经无法满足师生的移动办公需求。需要开发一套完整的移动端应用系统。', '开发一套功能完善的智慧校园移动应用，提升师生的校园生活体验。', '完成移动端APP开发，包含前端界面、后端API、数据库设计等完整功能。', 'http://123.56.113.24:9100/hit-bucket/2025/08/12/56c94addb07349f8ab4a75517590a22e.png', 'academic', 'computer', 3, 'medium', '2025-02-01', '2025-07-31', 3, 6, 3, 'recruiting', 'open', 'public', 'manual', 282, 24, 12, 2, '1', '0', '1', 1, NULL, '000000', NULL, 1, '2025-08-12 09:49:07', 1, '2025-08-16 04:21:12', NULL, NULL);
INSERT INTO `hit_project` (`project_id`, `project_name`, `project_description`, `project_background`, `project_goals`, `expected_outcome`, `cover_image`, `project_type`, `project_category`, `difficulty_level`, `duration_type`, `start_date`, `end_date`, `team_size_min`, `team_size_max`, `current_members`, `status`, `recruitment_status`, `visibility`, `approval_mode`, `view_count`, `like_count`, `collect_count`, `apply_count`, `is_featured`, `is_urgent`, `is_credit`, `creator_id`, `mentor_id`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (2, '人工智能图像识别系统', '基于深度学习的图像识别系统，能够识别校园内的各种物体和场景，为智慧校园建设提供技术支持。', '人工智能技术在图像识别领域发展迅速，将AI技术应用到校园管理中具有重要意义。', '研发一套高精度的图像识别系统，提升校园智能化水平。', '完成AI模型训练、系统集成、性能优化等工作，达到实用化标准。', 'http://123.56.113.24:9100/hit-bucket/2025/08/12/7bb076b32c524e10b5356a663dcf360c.png', 'competition', 'computer', 4, 'long', '2025-01-15', '2025-12-31', 4, 8, 3, 'recruiting', 'open', 'public', 'manual', 102, 15, 7, 1, '1', '1', '0', 1, NULL, '000000', NULL, 1, '2025-08-12 09:49:07', 1, '2025-08-15 09:48:24', NULL, NULL);
INSERT INTO `hit_project` (`project_id`, `project_name`, `project_description`, `project_background`, `project_goals`, `expected_outcome`, `cover_image`, `project_type`, `project_category`, `difficulty_level`, `duration_type`, `start_date`, `end_date`, `team_size_min`, `team_size_max`, `current_members`, `status`, `recruitment_status`, `visibility`, `approval_mode`, `view_count`, `like_count`, `collect_count`, `apply_count`, `is_featured`, `is_urgent`, `is_credit`, `creator_id`, `mentor_id`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (4, '机器人控制系统设计', '设计并实现一个多功能服务机器人的控制系统，包含导航、避障、语音交互等功能。', '服务机器人在教育、医疗、家庭等领域应用前景广阔，控制系统是核心技术。', '开发一套稳定可靠的机器人控制系统。', '完成控制算法设计、硬件集成、系统测试等工作。', 'http://123.56.113.24:9100/hit-bucket/2025/08/12/6da83a31d5084074a3df23b0b1b0a365.png', 'graduation', 'mechanical', 3, 'medium', '2025-02-15', '2025-06-15', 3, 5, 3, 'recruiting', 'open', 'public', 'manual', 86, 9, 4, 1, '0', '0', '0', 1, NULL, '000000', NULL, 1, '2025-08-12 09:49:07', 1, '2025-08-16 04:36:31', NULL, NULL);
INSERT INTO `hit_project` (`project_id`, `project_name`, `project_description`, `project_background`, `project_goals`, `expected_outcome`, `cover_image`, `project_type`, `project_category`, `difficulty_level`, `duration_type`, `start_date`, `end_date`, `team_size_min`, `team_size_max`, `current_members`, `status`, `recruitment_status`, `visibility`, `approval_mode`, `view_count`, `like_count`, `collect_count`, `apply_count`, `is_featured`, `is_urgent`, `is_credit`, `creator_id`, `mentor_id`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (1955984161988997122, '吹爆魔丸', '吹爆我的魔丸！！！！！', '魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸！！！', '', '', 'http://123.56.113.24:9100/hit-bucket/2025/08/14/b8960fa9ca404aa6ac77d1940ca5c00b.png', 'competition', NULL, 2, 'medium', '2025-08-14', '2025-08-29', 1, 5, 1, 'recruiting', 'open', 'public', 'auto', 92, 8, 7, 0, '0', '0', '0', 1, NULL, '000000', 103, 1, '2025-08-14 21:25:39', 1, '2025-08-16 04:20:06', NULL, NULL);
COMMIT;

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='项目申请表';

-- ----------------------------
-- Records of hit_project_application
-- ----------------------------
BEGIN;
INSERT INTO `hit_project_application` (`application_id`, `project_id`, `user_id`, `role_id`, `application_reason`, `self_introduction`, `relevant_experience`, `expected_contribution`, `available_time`, `contact_info`, `resume_url`, `portfolio_url`, `application_status`, `review_result`, `review_time`, `reviewer_id`, `interview_time`, `interview_notes`, `priority_score`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `dept_id`) VALUES (1, 1, 2, NULL, '我对这个AI智能问答系统项目非常感兴趣，希望能够参与其中。我有Java和Python的开发经验，熟悉机器学习基础知识。', '我是计算机科学与技术专业的大三学生，对人工智能和自然语言处理有浓厚兴趣。曾参与过学校的创新创业项目。', '参与过一个简单的聊天机器人项目，使用Python和TensorFlow实现。有Java Web开发经验，熟悉Spring框架。', '我可以负责后端API开发和模型集成工作，预期每周投入20小时以上。', '每周可投入20-25小时，主要在晚上和周末', 'student2@hit.edu.cn', '/uploads/resume/student2_resume.pdf', 'https://github.com/student2/projects', 'pending', NULL, NULL, NULL, '2025-08-14 13:06:21', '面试时间安排：线上视频面试，主要考察技术能力和项目经验。', 75.50, '000000', NULL, 2, '2025-08-12 13:06:21', NULL, '2025-08-12 13:06:21', NULL);
INSERT INTO `hit_project_application` (`application_id`, `project_id`, `user_id`, `role_id`, `application_reason`, `self_introduction`, `relevant_experience`, `expected_contribution`, `available_time`, `contact_info`, `resume_url`, `portfolio_url`, `application_status`, `review_result`, `review_time`, `reviewer_id`, `interview_time`, `interview_notes`, `priority_score`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `dept_id`) VALUES (2, 1, 3, NULL, '希望通过参与这个项目提升自己的AI开发能力。我有扎实的数学基础和编程能力。', '计算机学院大二学生，数学成绩优秀，对深度学习很感兴趣。', '自学了机器学习相关课程，完成过手写数字识别项目。熟悉Python、PyTorch框架。', '可以负责数据处理和模型训练部分，学习能力强，能快速上手新技术。', '每周15-20小时', 'student3@hit.edu.cn', NULL, 'https://github.com/student3/ml-projects', 'pending', NULL, NULL, NULL, NULL, NULL, 68.00, '000000', NULL, 3, '2025-08-12 13:06:21', NULL, '2025-08-12 13:06:21', NULL);
INSERT INTO `hit_project_application` (`application_id`, `project_id`, `user_id`, `role_id`, `application_reason`, `self_introduction`, `relevant_experience`, `expected_contribution`, `available_time`, `contact_info`, `resume_url`, `portfolio_url`, `application_status`, `review_result`, `review_time`, `reviewer_id`, `interview_time`, `interview_notes`, `priority_score`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `dept_id`) VALUES (3, 2, 4, NULL, '对区块链技术很感兴趣，希望通过实际项目学习和应用区块链开发技术。', '软件工程专业学生，有较强的编程基础，对新技术有很强的学习热情。', '学习过Solidity智能合约开发，了解以太坊开发环境。有Node.js和React开发经验。', '可以参与智能合约开发和前端界面设计，预期贡献高质量代码。', '每周18-22小时', 'student4@hit.edu.cn', '/uploads/resume/student4_resume.pdf', NULL, 'rejected', '感谢您的申请，但目前项目团队已满员，期待下次合作机会。', '2025-08-11 13:06:21', 1, NULL, NULL, 82.25, '000000', NULL, 4, '2025-08-12 13:06:21', NULL, '2025-08-12 13:06:21', NULL);
INSERT INTO `hit_project_application` (`application_id`, `project_id`, `user_id`, `role_id`, `application_reason`, `self_introduction`, `relevant_experience`, `expected_contribution`, `available_time`, `contact_info`, `resume_url`, `portfolio_url`, `application_status`, `review_result`, `review_time`, `reviewer_id`, `interview_time`, `interview_notes`, `priority_score`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `dept_id`) VALUES (4, 3, 5, NULL, '我对物联网技术非常感兴趣，希望参与智能家居系统的开发。', '电子信息工程专业学生，有嵌入式开发经验，熟悉Arduino和树莓派。', '参与过智能温控系统项目，熟悉传感器使用和数据采集。有C/C++和Python编程经验。', '负责硬件开发和传感器集成，确保系统稳定运行。', '每周20小时以上', 'student5@hit.edu.cn', NULL, 'https://github.com/student5/iot-projects', 'pending', NULL, NULL, NULL, NULL, NULL, 90.75, '000000', NULL, 5, '2025-08-12 13:06:21', NULL, '2025-08-12 13:06:21', NULL);
INSERT INTO `hit_project_application` (`application_id`, `project_id`, `user_id`, `role_id`, `application_reason`, `self_introduction`, `relevant_experience`, `expected_contribution`, `available_time`, `contact_info`, `resume_url`, `portfolio_url`, `application_status`, `review_result`, `review_time`, `reviewer_id`, `interview_time`, `interview_notes`, `priority_score`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `dept_id`) VALUES (5, 4, 6, NULL, '希望参与机器人项目，提升自己在机器人控制和视觉识别方面的能力。', '自动化专业研究生，有机器人开发经验，熟悉ROS系统。', '参与过机器人竞赛，有路径规划和图像识别算法开发经验。熟悉OpenCV和PCL点云库。', '负责机器人导航算法和视觉识别模块开发，确保项目技术先进性。', '每周25-30小时', 'student6@hit.edu.cn', '/uploads/resume/student6_resume.pdf', 'https://github.com/student6/robotics', 'approved', '申请者技术背景符合项目需求，欢迎加入团队！', '2025-08-12 13:06:21', 1, NULL, NULL, 95.50, '000000', NULL, 6, '2025-08-12 13:06:21', NULL, '2025-08-12 13:06:21', NULL);
INSERT INTO `hit_project_application` (`application_id`, `project_id`, `user_id`, `role_id`, `application_reason`, `self_introduction`, `relevant_experience`, `expected_contribution`, `available_time`, `contact_info`, `resume_url`, `portfolio_url`, `application_status`, `review_result`, `review_time`, `reviewer_id`, `interview_time`, `interview_notes`, `priority_score`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `dept_id`) VALUES (6, 5, 7, NULL, '对移动应用开发很感兴趣，希望通过这个项目学习最新的移动开发技术。', '软件工程专业学生，有Android开发经验，对跨平台开发感兴趣。', '开发过几个Android应用，熟悉Java和Kotlin。学习过Flutter框架，有小程序开发经验。', '负责移动端应用开发，保证用户体验良好，界面美观实用。', '每周15-20小时', 'student7@hit.edu.cn', NULL, NULL, 'pending', NULL, NULL, NULL, NULL, NULL, 72.00, '000000', NULL, 7, '2025-08-12 13:06:21', NULL, '2025-08-12 13:06:21', NULL);
INSERT INTO `hit_project_application` (`application_id`, `project_id`, `user_id`, `role_id`, `application_reason`, `self_introduction`, `relevant_experience`, `expected_contribution`, `available_time`, `contact_info`, `resume_url`, `portfolio_url`, `application_status`, `review_result`, `review_time`, `reviewer_id`, `interview_time`, `interview_notes`, `priority_score`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `dept_id`) VALUES (7, 1, 8, NULL, '测试撤回功能的申请', '测试用户', NULL, NULL, NULL, NULL, NULL, NULL, 'withdrawn', NULL, NULL, NULL, NULL, NULL, 50.00, '000000', NULL, 8, '2025-08-10 13:06:21', NULL, '2025-08-12 13:06:21', NULL);
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
COMMIT;

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
) ENGINE=InnoDB AUTO_INCREMENT=1955998959283793922 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='项目成员表';

-- ----------------------------
-- Records of hit_project_member
-- ----------------------------
BEGIN;
INSERT INTO `hit_project_member` (`member_id`, `project_id`, `user_id`, `role_id`, `member_role`, `join_time`, `leave_time`, `member_status`, `contribution_score`, `completed_tasks`, `total_tasks`, `work_hours`, `performance_rating`, `is_leader`, `permissions`, `remark`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `dept_id`) VALUES (1, 1, 1, 1, '项目负责人', '2025-08-12 13:06:38', NULL, 'active', 100.00, 5, 5, 80.00, 5.00, '1', '[\"view_project\", \"edit_tasks\", \"manage_files\", \"manage_members\", \"project_settings\"]', '项目创建者', '000000', NULL, 1, '2025-08-12 13:06:38', NULL, '2025-08-14 08:40:26', NULL);
INSERT INTO `hit_project_member` (`member_id`, `project_id`, `user_id`, `role_id`, `member_role`, `join_time`, `leave_time`, `member_status`, `contribution_score`, `completed_tasks`, `total_tasks`, `work_hours`, `performance_rating`, `is_leader`, `permissions`, `remark`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `dept_id`) VALUES (2, 2, 1, 8, '项目负责人', '2025-08-12 13:06:38', NULL, 'active', 100.00, 3, 3, 60.00, 5.00, '1', '[\"view_project\", \"edit_tasks\", \"manage_files\", \"manage_members\", \"project_settings\"]', '项目创建者', '000000', NULL, 1, '2025-08-12 13:06:38', NULL, '2025-08-14 08:40:26', NULL);
INSERT INTO `hit_project_member` (`member_id`, `project_id`, `user_id`, `role_id`, `member_role`, `join_time`, `leave_time`, `member_status`, `contribution_score`, `completed_tasks`, `total_tasks`, `work_hours`, `performance_rating`, `is_leader`, `permissions`, `remark`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `dept_id`) VALUES (3, 3, 1, 16, '项目负责人', '2025-08-12 13:06:38', NULL, 'active', 100.00, 2, 2, 40.00, 5.00, '1', '[\"view_project\", \"edit_tasks\", \"manage_files\", \"manage_members\", \"project_settings\"]', '项目创建者', '000000', NULL, 1, '2025-08-12 13:06:38', NULL, '2025-08-14 08:40:26', NULL);
INSERT INTO `hit_project_member` (`member_id`, `project_id`, `user_id`, `role_id`, `member_role`, `join_time`, `leave_time`, `member_status`, `contribution_score`, `completed_tasks`, `total_tasks`, `work_hours`, `performance_rating`, `is_leader`, `permissions`, `remark`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `dept_id`) VALUES (4, 4, 1, 24, '项目负责人', '2025-08-12 13:06:38', NULL, 'active', 100.00, 4, 4, 70.00, 5.00, '1', '[\"view_project\", \"edit_tasks\", \"manage_files\", \"manage_members\", \"project_settings\"]', '项目创建者', '000000', NULL, 1, '2025-08-12 13:06:38', NULL, '2025-08-14 08:40:27', NULL);
INSERT INTO `hit_project_member` (`member_id`, `project_id`, `user_id`, `role_id`, `member_role`, `join_time`, `leave_time`, `member_status`, `contribution_score`, `completed_tasks`, `total_tasks`, `work_hours`, `performance_rating`, `is_leader`, `permissions`, `remark`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `dept_id`) VALUES (5, 5, 1, 32, '项目负责人', '2025-08-12 13:06:38', NULL, 'active', 100.00, 1, 1, 20.00, 5.00, '1', '[\"view_project\", \"edit_tasks\", \"manage_files\", \"manage_members\", \"project_settings\"]', '项目创建者', '000000', NULL, 1, '2025-08-12 13:06:38', NULL, '2025-08-14 08:40:27', NULL);
INSERT INTO `hit_project_member` (`member_id`, `project_id`, `user_id`, `role_id`, `member_role`, `join_time`, `leave_time`, `member_status`, `contribution_score`, `completed_tasks`, `total_tasks`, `work_hours`, `performance_rating`, `is_leader`, `permissions`, `remark`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `dept_id`) VALUES (7, 1, 3, 4, '算法工程师', '2025-08-09 13:06:38', NULL, 'active', 86.00, 2, 3, 47.00, 4.20, '0', '[\"view_project\", \"edit_tasks\", \"manage_files\"]', '通过申请加入', '000000', NULL, 1, '2025-08-09 13:06:38', NULL, '2025-08-14 08:40:26', NULL);
INSERT INTO `hit_project_member` (`member_id`, `project_id`, `user_id`, `role_id`, `member_role`, `join_time`, `leave_time`, `member_status`, `contribution_score`, `completed_tasks`, `total_tasks`, `work_hours`, `performance_rating`, `is_leader`, `permissions`, `remark`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `dept_id`) VALUES (8, 2, 4, 11, '区块链开发工程师', '2025-08-10 13:06:38', NULL, 'active', 82.25, 2, 3, 38.00, 4.10, '0', '[\"view_project\", \"edit_tasks\", \"manage_files\"]', '通过申请加入', '000000', NULL, 1, '2025-08-10 13:06:38', NULL, '2025-08-14 08:40:26', NULL);
INSERT INTO `hit_project_member` (`member_id`, `project_id`, `user_id`, `role_id`, `member_role`, `join_time`, `leave_time`, `member_status`, `contribution_score`, `completed_tasks`, `total_tasks`, `work_hours`, `performance_rating`, `is_leader`, `permissions`, `remark`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `dept_id`) VALUES (9, 1, 1955607159649886210, 2, '前端开发工程师', '2025-08-11 13:06:38', NULL, 'active', 75.50, 1, 2, 25.00, 3.80, '0', '[\"view_project\", \"edit_tasks\"]', '新加入成员', '000000', NULL, 1, '2025-08-11 13:06:38', NULL, '2025-08-14 08:40:26', NULL);
INSERT INTO `hit_project_member` (`member_id`, `project_id`, `user_id`, `role_id`, `member_role`, `join_time`, `leave_time`, `member_status`, `contribution_score`, `completed_tasks`, `total_tasks`, `work_hours`, `performance_rating`, `is_leader`, `permissions`, `remark`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `dept_id`) VALUES (10, 2, 1955607220618289154, 10, '后端开发工程师', '2025-08-11 13:06:38', NULL, 'active', 78.30, 2, 2, 32.00, 3.90, '0', '[\"view_project\", \"edit_tasks\", \"manage_files\"]', '新加入成员', '000000', NULL, 1, '2025-08-11 13:06:38', NULL, '2025-08-14 08:40:26', NULL);
INSERT INTO `hit_project_member` (`member_id`, `project_id`, `user_id`, `role_id`, `member_role`, `join_time`, `leave_time`, `member_status`, `contribution_score`, `completed_tasks`, `total_tasks`, `work_hours`, `performance_rating`, `is_leader`, `permissions`, `remark`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `dept_id`) VALUES (11, 5, 1953827752052592642, 33, '物联网开发工程师', '2025-08-12 13:06:38', NULL, 'active', 65.75, 1, 1, 15.00, 3.30, '0', '[\"view_project\", \"edit_tasks\"]', '物联网技术专家', '000000', NULL, 1, '2025-08-12 13:06:38', NULL, '2025-08-14 08:40:27', NULL);
INSERT INTO `hit_project_member` (`member_id`, `project_id`, `user_id`, `role_id`, `member_role`, `join_time`, `leave_time`, `member_status`, `contribution_score`, `completed_tasks`, `total_tasks`, `work_hours`, `performance_rating`, `is_leader`, `permissions`, `remark`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `dept_id`) VALUES (12, 4, 3, 26, '机械设计工程师', '2025-08-12 13:06:38', NULL, 'active', 88.75, 3, 4, 45.00, 4.40, '0', '[\"view_project\", \"edit_tasks\", \"manage_files\"]', '跨项目参与', '000000', NULL, 1, '2025-08-12 13:06:38', NULL, '2025-08-14 08:40:27', NULL);
INSERT INTO `hit_project_member` (`member_id`, `project_id`, `user_id`, `role_id`, `member_role`, `join_time`, `leave_time`, `member_status`, `contribution_score`, `completed_tasks`, `total_tasks`, `work_hours`, `performance_rating`, `is_leader`, `permissions`, `remark`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `dept_id`) VALUES (13, 3, 4, 18, '智能合约开发工程师', '2025-08-13 13:06:38', NULL, 'active', 92.50, 4, 5, 55.00, 4.60, '0', '[\"view_project\", \"edit_tasks\", \"manage_files\"]', '区块链专家', '000000', NULL, 1, '2025-08-13 13:06:38', NULL, '2025-08-14 08:40:26', NULL);
INSERT INTO `hit_project_member` (`member_id`, `project_id`, `user_id`, `role_id`, `member_role`, `join_time`, `leave_time`, `member_status`, `contribution_score`, `completed_tasks`, `total_tasks`, `work_hours`, `performance_rating`, `is_leader`, `permissions`, `remark`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `dept_id`) VALUES (1955984163020795905, 1955984161988997122, 1, 1955984162521673730, '项目负责人', '2025-08-14 21:25:40', NULL, 'active', 0.00, 0, 0, 0.00, 0.00, '1', NULL, NULL, '000000', 103, 1, '2025-08-14 21:25:40', 1, '2025-08-14 21:25:40', NULL);
INSERT INTO `hit_project_member` (`member_id`, `project_id`, `user_id`, `role_id`, `member_role`, `join_time`, `leave_time`, `member_status`, `contribution_score`, `completed_tasks`, `total_tasks`, `work_hours`, `performance_rating`, `is_leader`, `permissions`, `remark`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `dept_id`) VALUES (1955998959283793921, 1955984161988997122, 1955607159649886210, NULL, '前端工程师', '2025-08-14 22:24:27', NULL, 'active', 0.00, 0, 0, 0.00, 0.00, '0', NULL, NULL, '000000', 103, 1, '2025-08-14 22:24:27', 1, '2025-08-14 14:24:34', NULL);
COMMIT;

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
BEGIN;
COMMIT;

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
) ENGINE=InnoDB AUTO_INCREMENT=1955984164908232706 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='项目角色定义表';

-- ----------------------------
-- Records of hit_project_role
-- ----------------------------
BEGIN;
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (1, 1, '项目负责人', '负责项目整体规划和团队管理', '[\"项目管理\", \"团队协作\", \"技术架构\"]', '制定项目计划、协调团队工作、把控项目进度', 1, 1, '2年以上', '每周20小时以上', '1', 1, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:27', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (2, 1, '前端开发工程师', '负责移动端界面开发', '[\"Vue3\", \"TypeScript\", \"移动端开发\"]', '开发移动端界面、优化用户体验、前后端联调', 2, 1, '1年以上', '每周15小时', '0', 2, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:27', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (3, 1, '后端开发工程师', '负责后端API开发', '[\"Spring Boot\", \"MySQL\", \"Redis\"]', '设计开发后端API、数据库设计、系统架构', 2, 0, '1年以上', '每周15小时', '0', 2, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:26', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (4, 1, '算法工程师', '负责核心算法设计与实现', '[\"机器学习\", \"数据挖掘\", \"Python\"]', '设计核心算法、数据分析、模型优化', 1, 1, '1年以上', '每周10小时', '0', 3, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:27', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (5, 1, '核心成员', '项目核心贡献者', '[\"专业技能\", \"责任心强\"]', '承担重要模块开发、参与技术决策', 2, 0, '6个月以上', '每周10小时', '0', 4, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:26', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (6, 1, '普通成员', '项目一般参与者', '[\"基础技能\", \"学习能力\"]', '参与具体功能开发、学习提升', 3, 0, '无要求', '每周5小时', '0', 5, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:26', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (7, 1, '观察者', '项目观察学习者', '[\"学习意愿\"]', '观察项目进展、学习经验', 5, 0, '无要求', '每周2小时', '0', 6, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:26', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (8, 2, '项目负责人', '负责AI项目整体规划和研发管理', '[\"深度学习\", \"项目管理\", \"研究能力\"]', '制定研发计划、技术方向把控、团队协调', 1, 1, '3年以上', '每周25小时以上', '1', 1, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:27', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (9, 2, '算法工程师', '负责深度学习模型设计', '[\"深度学习\", \"Python\", \"TensorFlow/PyTorch\"]', '模型设计、训练优化、算法改进', 2, 0, '2年以上', '每周20小时', '0', 2, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:26', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (10, 2, '后端开发工程师', '负责AI服务后端开发', '[\"Spring Boot\", \"微服务\", \"高并发\"]', '开发AI服务接口、系统架构设计', 2, 1, '1年以上', '每周15小时', '0', 2, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:27', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (11, 2, '区块链开发工程师', '负责区块链相关功能', '[\"区块链\", \"智能合约\", \"去中心化\"]', '区块链技术集成、智能合约开发', 1, 1, '1年以上', '每周10小时', '0', 3, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:27', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (12, 2, '数据工程师', '负责数据处理和标注', '[\"数据处理\", \"数据标注\", \"SQL\"]', '数据收集清洗、模型训练数据准备', 1, 0, '6个月以上', '每周10小时', '0', 3, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:26', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (13, 2, '核心成员', '项目核心贡献者', '[\"AI相关技能\", \"研究能力\"]', '承担核心功能开发、技术攻关', 2, 0, '1年以上', '每周12小时', '0', 4, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:26', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (14, 2, '普通成员', '项目一般参与者', '[\"编程基础\", \"学习能力\"]', '辅助功能开发、测试验证', 3, 0, '无要求', '每周6小时', '0', 5, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:26', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (15, 2, '观察者', '项目观察学习者', '[\"AI学习兴趣\"]', '学习AI技术、观察项目进展', 5, 0, '无要求', '每周3小时', '0', 6, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:26', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (16, 3, '项目负责人', '负责区块链项目规划和技术方向', '[\"区块链架构\", \"金融知识\", \"项目管理\"]', '技术方案设计、团队管理、风险控制', 1, 1, '3年以上', '每周25小时以上', '1', 1, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:27', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (17, 3, '区块链开发工程师', '负责区块链底层开发', '[\"区块链\", \"Solidity\", \"Web3\"]', '区块链底层开发、共识算法实现', 2, 0, '2年以上', '每周20小时', '0', 2, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:26', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (18, 3, '智能合约开发工程师', '负责智能合约设计开发', '[\"Solidity\", \"智能合约\", \"安全审计\"]', '智能合约开发、安全测试、部署维护', 2, 1, '1年以上', '每周18小时', '0', 2, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:27', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (19, 3, '前端开发工程师', '负责DApp前端开发', '[\"Vue/React\", \"Web3.js\", \"DApp开发\"]', '去中心化应用前端、用户界面开发', 1, 0, '1年以上', '每周15小时', '0', 3, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:26', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (20, 3, '后端开发工程师', '负责传统后端服务', '[\"Java/Node.js\", \"数据库\", \"API设计\"]', '后端服务开发、数据存储、接口设计', 1, 0, '1年以上', '每周12小时', '0', 3, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:26', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (21, 3, '核心成员', '项目核心贡献者', '[\"区块链基础\", \"金融理解\"]', '核心功能开发、技术研究', 2, 0, '6个月以上', '每周10小时', '0', 4, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:26', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (22, 3, '普通成员', '项目一般参与者', '[\"编程基础\", \"区块链兴趣\"]', '功能开发、测试工作', 2, 0, '无要求', '每周6小时', '0', 5, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:26', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (23, 3, '观察者', '项目观察学习者', '[\"区块链学习兴趣\"]', '学习区块链技术、观察项目', 3, 0, '无要求', '每周3小时', '0', 6, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:26', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (24, 4, '项目负责人', '负责机器人项目整体设计', '[\"机器人学\", \"控制理论\", \"项目管理\"]', '系统架构设计、技术方案制定、团队协调', 1, 1, '3年以上', '每周25小时以上', '1', 1, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:27', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (25, 4, '控制系统工程师', '负责控制算法设计', '[\"控制理论\", \"MATLAB/Simulink\", \"嵌入式\"]', '控制算法设计、系统建模、参数调优', 2, 0, '2年以上', '每周20小时', '0', 2, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:26', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (26, 4, '机械设计工程师', '负责机械结构设计', '[\"机械设计\", \"CAD\", \"结构分析\"]', '机械结构设计、运动学分析、强度校核', 2, 1, '1年以上', '每周18小时', '0', 2, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:27', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (27, 4, '嵌入式工程师', '负责底层硬件控制', '[\"嵌入式C\", \"单片机\", \"传感器\"]', '底层驱动开发、传感器集成、实时控制', 1, 0, '1年以上', '每周15小时', '0', 3, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:26', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (28, 4, '软件工程师', '负责上层软件开发', '[\"C++/Python\", \"ROS\", \"算法实现\"]', '导航算法、路径规划、人机交互', 1, 0, '1年以上', '每周12小时', '0', 3, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:26', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (29, 4, '核心成员', '项目核心贡献者', '[\"机械/电子基础\", \"动手能力\"]', '核心模块开发、系统集成', 2, 0, '6个月以上', '每周10小时', '0', 4, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:26', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (30, 4, '普通成员', '项目一般参与者', '[\"理工科基础\", \"学习能力\"]', '辅助开发、测试调试', 2, 0, '无要求', '每周6小时', '0', 5, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:26', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (31, 4, '观察者', '项目观察学习者', '[\"机器人兴趣\"]', '学习机器人技术、观察项目', 3, 0, '无要求', '每周3小时', '0', 6, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:26', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (32, 5, '项目负责人', '负责物联网项目整体规划', '[\"物联网架构\", \"系统设计\", \"项目管理\"]', '系统架构设计、技术选型、进度管控', 1, 1, '2年以上', '每周20小时以上', '1', 1, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:27', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (33, 5, '物联网开发工程师', '负责物联网核心开发', '[\"物联网\", \"传感器\", \"通信协议\"]', '设备连接、数据采集、协议开发', 2, 1, '1年以上', '每周18小时', '0', 2, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:27', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (34, 5, '嵌入式工程师', '负责设备端开发', '[\"嵌入式C\", \"Arduino/树莓派\", \"传感器\"]', '智能设备开发、传感器集成、固件编程', 1, 0, '1年以上', '每周15小时', '0', 2, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:26', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (35, 5, '后端工程师', '负责云端服务开发', '[\"Java/Python\", \"云平台\", \"大数据\"]', '云端数据处理、后台管理、API开发', 1, 0, '1年以上', '每周12小时', '0', 3, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:26', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (36, 5, '移动端工程师', '负责手机APP开发', '[\"Android/iOS\", \"移动开发\", \"UI设计\"]', '移动端控制界面、用户体验优化', 1, 0, '6个月以上', '每周10小时', '0', 3, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:26', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (37, 5, '核心成员', '项目核心贡献者', '[\"电子/计算机基础\", \"创新能力\"]', '核心功能实现、技术攻关', 1, 0, '6个月以上', '每周8小时', '0', 4, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:26', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (38, 5, '普通成员', '项目一般参与者', '[\"理工科基础\", \"动手能力\"]', '功能开发、测试验证', 2, 0, '无要求', '每周5小时', '0', 5, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:26', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (39, 5, '观察者', '项目观察学习者', '[\"物联网兴趣\"]', '学习物联网技术、项目观察', 3, 0, '无要求', '每周2小时', '0', 6, '0', '000000', NULL, 1, '2025-08-14 08:40:26', NULL, '2025-08-14 08:40:26', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (1955984162521673730, 1955984161988997122, '项目负责人', '负责项目整体规划和团队管理', '[\"项目管理\", \"团队协作\", \"技术架构\"]', '制定项目计划、协调团队工作、把控项目进度', 1, 1, NULL, NULL, '1', 1, '0', '000000', 103, 1, '2025-08-14 21:25:39', 1, '2025-08-14 21:25:39', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (1955984164694323201, 1955984161988997122, '前端工程师', '有前端开发经验', 'Vue', NULL, 3, 0, NULL, NULL, '0', 2, '0', '000000', 103, 1, '2025-08-14 21:25:40', 1, '2025-08-14 21:25:40', NULL, NULL);
INSERT INTO `hit_project_role` (`role_id`, `project_id`, `role_name`, `role_description`, `required_skills`, `responsibilities`, `required_count`, `current_count`, `experience_required`, `time_commitment`, `is_leader`, `priority`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (1955984164908232705, 1955984161988997122, '后端开发工程师', '后端开发经验', 'JAVA', NULL, 1, 0, NULL, NULL, '0', 2, '0', '000000', 103, 1, '2025-08-14 21:25:40', 1, '2025-08-14 21:25:40', NULL, NULL);
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
INSERT INTO `hit_skill_tag` (`tag_id`, `tag_name`, `tag_category`, `tag_description`, `parent_id`, `sort_order`, `is_hot`, `use_count`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (1, 'Java', 'programming', 'Java编程语言', 0, 1, '1', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
INSERT INTO `hit_skill_tag` (`tag_id`, `tag_name`, `tag_category`, `tag_description`, `parent_id`, `sort_order`, `is_hot`, `use_count`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (2, 'Python', 'programming', 'Python编程语言', 0, 2, '1', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
INSERT INTO `hit_skill_tag` (`tag_id`, `tag_name`, `tag_category`, `tag_description`, `parent_id`, `sort_order`, `is_hot`, `use_count`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (3, 'JavaScript', 'programming', 'JavaScript编程语言', 0, 3, '1', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
INSERT INTO `hit_skill_tag` (`tag_id`, `tag_name`, `tag_category`, `tag_description`, `parent_id`, `sort_order`, `is_hot`, `use_count`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (4, 'C++', 'programming', 'C++编程语言', 0, 4, '1', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
INSERT INTO `hit_skill_tag` (`tag_id`, `tag_name`, `tag_category`, `tag_description`, `parent_id`, `sort_order`, `is_hot`, `use_count`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (5, 'C', 'programming', 'C编程语言', 0, 5, '0', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
INSERT INTO `hit_skill_tag` (`tag_id`, `tag_name`, `tag_category`, `tag_description`, `parent_id`, `sort_order`, `is_hot`, `use_count`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (6, 'Go', 'programming', 'Go编程语言', 0, 6, '0', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
INSERT INTO `hit_skill_tag` (`tag_id`, `tag_name`, `tag_category`, `tag_description`, `parent_id`, `sort_order`, `is_hot`, `use_count`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (7, 'Rust', 'programming', 'Rust编程语言', 0, 7, '0', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
INSERT INTO `hit_skill_tag` (`tag_id`, `tag_name`, `tag_category`, `tag_description`, `parent_id`, `sort_order`, `is_hot`, `use_count`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (8, 'Spring Boot', 'framework', 'Java企业级开发框架', 0, 1, '1', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
INSERT INTO `hit_skill_tag` (`tag_id`, `tag_name`, `tag_category`, `tag_description`, `parent_id`, `sort_order`, `is_hot`, `use_count`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (9, 'Vue.js', 'framework', '前端开发框架', 0, 2, '1', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
INSERT INTO `hit_skill_tag` (`tag_id`, `tag_name`, `tag_category`, `tag_description`, `parent_id`, `sort_order`, `is_hot`, `use_count`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (10, 'React', 'framework', '前端开发框架', 0, 3, '1', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
INSERT INTO `hit_skill_tag` (`tag_id`, `tag_name`, `tag_category`, `tag_description`, `parent_id`, `sort_order`, `is_hot`, `use_count`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (11, 'Django', 'framework', 'Python Web框架', 0, 4, '0', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
INSERT INTO `hit_skill_tag` (`tag_id`, `tag_name`, `tag_category`, `tag_description`, `parent_id`, `sort_order`, `is_hot`, `use_count`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (12, 'Flask', 'framework', 'Python Web框架', 0, 5, '0', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
INSERT INTO `hit_skill_tag` (`tag_id`, `tag_name`, `tag_category`, `tag_description`, `parent_id`, `sort_order`, `is_hot`, `use_count`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (13, 'Node.js', 'framework', 'JavaScript运行环境', 0, 6, '1', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
INSERT INTO `hit_skill_tag` (`tag_id`, `tag_name`, `tag_category`, `tag_description`, `parent_id`, `sort_order`, `is_hot`, `use_count`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (14, '算法设计', 'design', '算法设计与分析', 0, 1, '1', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
INSERT INTO `hit_skill_tag` (`tag_id`, `tag_name`, `tag_category`, `tag_description`, `parent_id`, `sort_order`, `is_hot`, `use_count`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (15, '数据分析', 'design', '数据挖掘与分析', 0, 2, '1', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
INSERT INTO `hit_skill_tag` (`tag_id`, `tag_name`, `tag_category`, `tag_description`, `parent_id`, `sort_order`, `is_hot`, `use_count`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (16, 'UI设计', 'design', '用户界面设计', 0, 3, '1', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
INSERT INTO `hit_skill_tag` (`tag_id`, `tag_name`, `tag_category`, `tag_description`, `parent_id`, `sort_order`, `is_hot`, `use_count`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (17, 'UX设计', 'design', '用户体验设计', 0, 4, '0', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
INSERT INTO `hit_skill_tag` (`tag_id`, `tag_name`, `tag_category`, `tag_description`, `parent_id`, `sort_order`, `is_hot`, `use_count`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (18, '机器学习', 'design', '机器学习算法', 0, 5, '1', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
INSERT INTO `hit_skill_tag` (`tag_id`, `tag_name`, `tag_category`, `tag_description`, `parent_id`, `sort_order`, `is_hot`, `use_count`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (19, '深度学习', 'design', '深度学习技术', 0, 6, '1', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
INSERT INTO `hit_skill_tag` (`tag_id`, `tag_name`, `tag_category`, `tag_description`, `parent_id`, `sort_order`, `is_hot`, `use_count`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (20, '团队协作', 'soft_skill', '团队合作能力', 0, 1, '1', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
INSERT INTO `hit_skill_tag` (`tag_id`, `tag_name`, `tag_category`, `tag_description`, `parent_id`, `sort_order`, `is_hot`, `use_count`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (21, '项目管理', 'soft_skill', '项目管理能力', 0, 2, '1', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
INSERT INTO `hit_skill_tag` (`tag_id`, `tag_name`, `tag_category`, `tag_description`, `parent_id`, `sort_order`, `is_hot`, `use_count`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (22, '沟通能力', 'soft_skill', '沟通表达能力', 0, 3, '1', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
INSERT INTO `hit_skill_tag` (`tag_id`, `tag_name`, `tag_category`, `tag_description`, `parent_id`, `sort_order`, `is_hot`, `use_count`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (23, '领导力', 'soft_skill', '领导管理能力', 0, 4, '0', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
INSERT INTO `hit_skill_tag` (`tag_id`, `tag_name`, `tag_category`, `tag_description`, `parent_id`, `sort_order`, `is_hot`, `use_count`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (24, '创新思维', 'soft_skill', '创新创造能力', 0, 5, '1', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
INSERT INTO `hit_skill_tag` (`tag_id`, `tag_name`, `tag_category`, `tag_description`, `parent_id`, `sort_order`, `is_hot`, `use_count`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (25, '编程', 'hobby', '编程开发兴趣', 0, 1, '1', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
INSERT INTO `hit_skill_tag` (`tag_id`, `tag_name`, `tag_category`, `tag_description`, `parent_id`, `sort_order`, `is_hot`, `use_count`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (26, '设计', 'hobby', '设计创作兴趣', 0, 2, '1', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
INSERT INTO `hit_skill_tag` (`tag_id`, `tag_name`, `tag_category`, `tag_description`, `parent_id`, `sort_order`, `is_hot`, `use_count`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (27, '音乐', 'hobby', '音乐爱好', 0, 3, '0', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
INSERT INTO `hit_skill_tag` (`tag_id`, `tag_name`, `tag_category`, `tag_description`, `parent_id`, `sort_order`, `is_hot`, `use_count`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (28, '运动', 'hobby', '体育运动', 0, 4, '0', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
INSERT INTO `hit_skill_tag` (`tag_id`, `tag_name`, `tag_category`, `tag_description`, `parent_id`, `sort_order`, `is_hot`, `use_count`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `user_id`, `dept_id`) VALUES (29, '阅读', 'hobby', '阅读学习', 0, 5, '0', 0, '0', '000000', NULL, 1, '2025-08-11 16:14:43', NULL, '2025-08-11 16:14:43', 1, 103);
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
COMMIT;

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='个人作品集表';

-- ----------------------------
-- Records of hit_user_portfolio
-- ----------------------------
BEGIN;
INSERT INTO `hit_user_portfolio` (`portfolio_id`, `user_id`, `title`, `description`, `work_type`, `cover_image`, `demo_url`, `repository_url`, `download_url`, `tech_stack`, `my_role`, `team_size`, `start_date`, `end_date`, `view_count`, `like_count`, `is_featured`, `is_public`, `sort_order`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `dept_id`) VALUES (4, 1, 'HIT项目组队通系统', '基于Spring Boot和Vue.js开发的项目组队管理系统，支持项目发布、团队组建、任务管理等功能', 'project', 'http://123.56.113.24:9100/hit-bucket/2025/08/12/2c67facc35144614ae63f589c7c2857f.png', 'https://demo.hit-project.com', 'https://github.com/zhangsan/hit-project', NULL, '[\"Spring Boot\", \"Vue.js\", \"MySQL\", \"Redis\"]', '全栈开发工程师', 5, '2024-01-01', '2024-06-01', 121, 25, '0', '0', 1, '0', '000000', 103, 1, '2025-08-11 16:09:18', 1, '2025-08-12 16:53:29', 103);
INSERT INTO `hit_user_portfolio` (`portfolio_id`, `user_id`, `title`, `description`, `work_type`, `cover_image`, `demo_url`, `repository_url`, `download_url`, `tech_stack`, `my_role`, `team_size`, `start_date`, `end_date`, `view_count`, `like_count`, `is_featured`, `is_public`, `sort_order`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `dept_id`) VALUES (5, 1, '个人博客系统', '使用Vue3和Spring Boot开发的个人博客系统，支持文章发布、评论、标签分类等功能', 'project', 'http://123.56.113.24:9100/hit-bucket/2025/08/12/163fe40dbb604c289dd5753466e798fa.png', 'https://blog.zhangsan.com', 'https://github.com/zhangsan/personal-blog', NULL, '[\"Vue3\", \"Spring Boot\", \"MyBatis Plus\", \"Element Plus\"]', '全栈开发工程师', 1, '2023-09-01', '2023-12-01', 85, 15, '0', '1', 2, '0', '000000', 103, 1, '2025-08-11 16:09:18', 1, '2025-08-12 17:01:49', 103);
COMMIT;

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户扩展档案表';

-- ----------------------------
-- Records of hit_user_profile
-- ----------------------------
BEGIN;
INSERT INTO `hit_user_profile` (`profile_id`, `user_id`, `student_id`, `real_name`, `college`, `major`, `grade`, `class_name`, `phone`, `email`, `qq`, `wechat`, `github`, `linkedin`, `personal_intro`, `career_plan`, `avatar_url`, `cover_url`, `reputation_score`, `total_projects`, `completed_projects`, `status`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `dept_id`) VALUES (3, 1, '2021001001', '迪迦', 'computer_science', '计算机科学与技术', '2021', '计算机2101班', '13800138001', 'zhangsan@hit.edu.cn', '123456789', 'zhangsan_wx', 'https://github.com/zhangsan', 'https://linkedin.com/in/zhangsan', '我是一名热爱编程的计算机专业学生，对全栈开发有浓厚兴趣，希望通过项目实践提升技术能力。', '目标成为一名优秀的全栈工程师，毕业后希望在知名互联网公司从事技术开发工作。', '/profile/avatar/1.jpg', '/profile/cover/1.jpg', 850.00, 15, 12, '0', '000000', 103, 1, '2025-08-11 16:09:18', 1, '2025-08-12 01:11:11', 103);
COMMIT;

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
) ENGINE=InnoDB AUTO_INCREMENT=1956274848638771202 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户技能关联表';

-- ----------------------------
-- Records of hit_user_skill
-- ----------------------------
BEGIN;
INSERT INTO `hit_user_skill` (`id`, `user_id`, `tag_id`, `skill_level`, `is_certified`, `certificate_url`, `learning_time`, `project_count`, `self_evaluation`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `dept_id`) VALUES (22, 1, 1, 4, '1', NULL, 24, 8, '熟练掌握Java核心技术，有丰富的企业级项目开发经验', '000000', 103, 1, '2025-08-11 16:09:18', 1, '2025-08-11 16:09:18', 103);
INSERT INTO `hit_user_skill` (`id`, `user_id`, `tag_id`, `skill_level`, `is_certified`, `certificate_url`, `learning_time`, `project_count`, `self_evaluation`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `dept_id`) VALUES (23, 1, 2, 3, '0', NULL, 12, 3, '熟悉Python基础语法，能进行简单的数据分析', '000000', 103, 1, '2025-08-11 16:09:18', 1, '2025-08-11 16:09:18', 103);
INSERT INTO `hit_user_skill` (`id`, `user_id`, `tag_id`, `skill_level`, `is_certified`, `certificate_url`, `learning_time`, `project_count`, `self_evaluation`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `dept_id`) VALUES (24, 1, 3, 4, '1', NULL, 18, 6, '精通JavaScript，熟练使用ES6+语法', '000000', 103, 1, '2025-08-11 16:09:18', 1, '2025-08-11 16:09:18', 103);
INSERT INTO `hit_user_skill` (`id`, `user_id`, `tag_id`, `skill_level`, `is_certified`, `certificate_url`, `learning_time`, `project_count`, `self_evaluation`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `dept_id`) VALUES (25, 1, 8, 5, '1', NULL, 30, 12, 'Spring Boot框架专家，有大型项目架构经验', '000000', 103, 1, '2025-08-11 16:09:18', 1, '2025-08-11 16:09:18', 103);
INSERT INTO `hit_user_skill` (`id`, `user_id`, `tag_id`, `skill_level`, `is_certified`, `certificate_url`, `learning_time`, `project_count`, `self_evaluation`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `dept_id`) VALUES (26, 1, 9, 4, '1', NULL, 20, 7, '熟练使用Vue.js开发前端应用', '000000', 103, 1, '2025-08-11 16:09:18', 1, '2025-08-11 16:09:18', 103);
INSERT INTO `hit_user_skill` (`id`, `user_id`, `tag_id`, `skill_level`, `is_certified`, `certificate_url`, `learning_time`, `project_count`, `self_evaluation`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `dept_id`) VALUES (27, 1, 20, 5, '0', NULL, 48, 15, '优秀的团队协作能力，擅长跨部门沟通', '000000', 103, 1, '2025-08-11 16:09:18', 1, '2025-08-11 16:09:18', 103);
INSERT INTO `hit_user_skill` (`id`, `user_id`, `tag_id`, `skill_level`, `is_certified`, `certificate_url`, `learning_time`, `project_count`, `self_evaluation`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `dept_id`) VALUES (28, 1, 21, 4, '0', NULL, 36, 10, '具备项目管理经验，熟悉敏捷开发流程', '000000', 103, 1, '2025-08-11 16:09:18', 1, '2025-08-11 16:09:18', 103);
INSERT INTO `hit_user_skill` (`id`, `user_id`, `tag_id`, `skill_level`, `is_certified`, `certificate_url`, `learning_time`, `project_count`, `self_evaluation`, `tenant_id`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `dept_id`) VALUES (1956274848638771201, 1955607159649886210, 1, 3, '1', NULL, 1, 0, NULL, '000000', 100, 1955607159649886210, '2025-08-15 16:40:44', 1955607159649886210, '2025-08-15 16:40:44', NULL);
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
INSERT INTO `sj_group_config` (`id`, `namespace_id`, `group_name`, `description`, `token`, `group_status`, `version`, `group_partition`, `id_generator_mode`, `init_scene`, `create_dt`, `update_dt`) VALUES (1, 'dev', 'ruoyi_group', '', 'SJ_cKqBTPzCsWA3VyuCfFoccmuIEGXjr5KT', 1, 1, 0, 1, 1, '2025-08-08 13:49:52', '2025-08-08 13:49:52');
INSERT INTO `sj_group_config` (`id`, `namespace_id`, `group_name`, `description`, `token`, `group_status`, `version`, `group_partition`, `id_generator_mode`, `init_scene`, `create_dt`, `update_dt`) VALUES (2, 'prod', 'ruoyi_group', '', 'SJ_cKqBTPzCsWA3VyuCfFoccmuIEGXjr5KT', 1, 1, 0, 1, 1, '2025-08-08 13:49:52', '2025-08-08 13:49:52');
COMMIT;

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
BEGIN;
INSERT INTO `sj_job` (`id`, `namespace_id`, `group_name`, `job_name`, `args_str`, `args_type`, `next_trigger_at`, `job_status`, `task_type`, `route_key`, `executor_type`, `executor_info`, `trigger_type`, `trigger_interval`, `block_strategy`, `executor_timeout`, `max_retry_times`, `parallel_num`, `retry_interval`, `bucket_index`, `resident`, `notify_ids`, `owner_id`, `description`, `ext_attrs`, `deleted`, `create_dt`, `update_dt`) VALUES (1, 'dev', 'ruoyi_group', 'demo-job', NULL, 1, 1710344035622, 1, 1, 4, 1, 'testJobExecutor', 2, '60', 1, 60, 3, 1, 1, 116, 0, '', 1, '', '', 0, '2025-08-08 13:49:53', '2025-08-08 13:49:53');
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
INSERT INTO `sj_namespace` (`id`, `name`, `unique_id`, `description`, `deleted`, `create_dt`, `update_dt`) VALUES (1, 'Development', 'dev', '', 0, '2025-08-08 13:49:52', '2025-08-08 13:49:52');
INSERT INTO `sj_namespace` (`id`, `name`, `unique_id`, `description`, `deleted`, `create_dt`, `update_dt`) VALUES (2, 'Production', 'prod', '', 0, '2025-08-08 13:49:52', '2025-08-08 13:49:52');
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
INSERT INTO `sj_system_user` (`id`, `username`, `password`, `role`, `create_dt`, `update_dt`) VALUES (1, 'admin', '465c194afb65670f38322df087f0a9bb225cc257e43eb4ac5a0c98ef5b3173ac', 2, '2025-08-08 13:49:53', '2025-08-08 13:49:53');
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
INSERT INTO `sys_client` (`id`, `client_id`, `client_key`, `client_secret`, `grant_type`, `device_type`, `active_timeout`, `timeout`, `status`, `del_flag`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1, 'e5cd7e4891bf95d1d19206ce24a7b32e', 'pc', 'pc123', 'password,social', 'pc', 1800, 604800, '0', '0', 103, 1, '2025-08-08 13:49:43', 1, '2025-08-08 13:49:43');
INSERT INTO `sys_client` (`id`, `client_id`, `client_key`, `client_secret`, `grant_type`, `device_type`, `active_timeout`, `timeout`, `status`, `del_flag`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (2, '428a8310cd442757ae699df5d894f051', 'app', 'app123', 'password,sms,social,wechat', 'android', 1800, 604800, '0', '0', 103, 1, '2025-08-08 13:49:43', 1, '2025-08-08 13:49:43');
COMMIT;

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
BEGIN;
INSERT INTO `sys_config` (`config_id`, `tenant_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '000000', '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` (`config_id`, `tenant_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '000000', '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '初始化密码 123456');
INSERT INTO `sys_config` (`config_id`, `tenant_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, '000000', '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` (`config_id`, `tenant_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (5, '000000', '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` (`config_id`, `tenant_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (11, '000000', 'OSS预览列表资源开关', 'sys.oss.previewListResource', 'true', 'Y', 103, 1, '2025-08-08 13:49:43', NULL, NULL, 'true:开启, false:关闭');
COMMIT;

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
BEGIN;
INSERT INTO `sys_dept` (`dept_id`, `tenant_id`, `parent_id`, `ancestors`, `dept_name`, `dept_category`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (100, '000000', 0, '0', 'XXX科技', NULL, 0, NULL, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2025-08-08 13:49:43', NULL, NULL);
INSERT INTO `sys_dept` (`dept_id`, `tenant_id`, `parent_id`, `ancestors`, `dept_name`, `dept_category`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (101, '000000', 100, '0,100', '深圳总公司', NULL, 1, NULL, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2025-08-08 13:49:43', NULL, NULL);
INSERT INTO `sys_dept` (`dept_id`, `tenant_id`, `parent_id`, `ancestors`, `dept_name`, `dept_category`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (102, '000000', 100, '0,100', '长沙分公司', NULL, 2, NULL, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2025-08-08 13:49:43', NULL, NULL);
INSERT INTO `sys_dept` (`dept_id`, `tenant_id`, `parent_id`, `ancestors`, `dept_name`, `dept_category`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (103, '000000', 101, '0,100,101', '研发部门', NULL, 1, 1, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2025-08-08 13:49:43', NULL, NULL);
INSERT INTO `sys_dept` (`dept_id`, `tenant_id`, `parent_id`, `ancestors`, `dept_name`, `dept_category`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (104, '000000', 101, '0,100,101', '市场部门', NULL, 2, NULL, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2025-08-08 13:49:43', NULL, NULL);
INSERT INTO `sys_dept` (`dept_id`, `tenant_id`, `parent_id`, `ancestors`, `dept_name`, `dept_category`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (105, '000000', 101, '0,100,101', '测试部门', NULL, 3, NULL, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2025-08-08 13:49:43', NULL, NULL);
INSERT INTO `sys_dept` (`dept_id`, `tenant_id`, `parent_id`, `ancestors`, `dept_name`, `dept_category`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (106, '000000', 101, '0,100,101', '财务部门', NULL, 4, NULL, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2025-08-08 13:49:43', NULL, NULL);
INSERT INTO `sys_dept` (`dept_id`, `tenant_id`, `parent_id`, `ancestors`, `dept_name`, `dept_category`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (107, '000000', 101, '0,100,101', '运维部门', NULL, 5, NULL, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2025-08-08 13:49:43', NULL, NULL);
INSERT INTO `sys_dept` (`dept_id`, `tenant_id`, `parent_id`, `ancestors`, `dept_name`, `dept_category`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (108, '000000', 102, '0,100,102', '市场部门', NULL, 1, NULL, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2025-08-08 13:49:43', NULL, NULL);
INSERT INTO `sys_dept` (`dept_id`, `tenant_id`, `parent_id`, `ancestors`, `dept_name`, `dept_category`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (109, '000000', 102, '0,100,102', '财务部门', NULL, 2, NULL, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2025-08-08 13:49:43', NULL, NULL);
COMMIT;

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
BEGIN;
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '000000', 1, '男', '0', 'sys_user_sex', '', '', 'Y', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '性别男');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '000000', 2, '女', '1', 'sys_user_sex', '', '', 'N', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '性别女');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, '000000', 3, '未知', '2', 'sys_user_sex', '', '', 'N', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '性别未知');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4, '000000', 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '显示菜单');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (5, '000000', 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (6, '000000', 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '正常状态');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (7, '000000', 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '停用状态');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (12, '000000', 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '系统默认是');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (13, '000000', 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '系统默认否');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (14, '000000', 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '通知');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (15, '000000', 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '公告');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (16, '000000', 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '正常状态');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (17, '000000', 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '关闭状态');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (18, '000000', 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '新增操作');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (19, '000000', 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '修改操作');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (20, '000000', 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '删除操作');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (21, '000000', 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '授权操作');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (22, '000000', 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '导出操作');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (23, '000000', 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '导入操作');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (24, '000000', 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '强退操作');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (25, '000000', 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '生成操作');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (26, '000000', 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '清空操作');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (27, '000000', 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '正常状态');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (28, '000000', 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '停用状态');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (29, '000000', 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '其他操作');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (30, '000000', 0, '密码认证', 'password', 'sys_grant_type', 'el-check-tag', 'default', 'N', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '密码认证');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (31, '000000', 0, '短信认证', 'sms', 'sys_grant_type', 'el-check-tag', 'default', 'N', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '短信认证');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (32, '000000', 0, '邮件认证', 'email', 'sys_grant_type', 'el-check-tag', 'default', 'N', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '邮件认证');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (33, '000000', 0, '小程序认证', 'xcx', 'sys_grant_type', 'el-check-tag', 'default', 'N', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '小程序认证');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (34, '000000', 0, '三方登录认证', 'social', 'sys_grant_type', 'el-check-tag', 'default', 'N', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '三方登录认证');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (35, '000000', 0, 'PC', 'pc', 'sys_device_type', '', 'default', 'N', 103, 1, '2025-08-08 13:49:43', NULL, NULL, 'PC');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (36, '000000', 0, '安卓', 'android', 'sys_device_type', '', 'default', 'N', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '安卓');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (37, '000000', 0, 'iOS', 'ios', 'sys_device_type', '', 'default', 'N', 103, 1, '2025-08-08 13:49:43', NULL, NULL, 'iOS');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (38, '000000', 0, '小程序', 'xcx', 'sys_device_type', '', 'default', 'N', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '小程序');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (39, '000000', 1, '已撤销', 'cancel', 'wf_business_status', '', 'danger', 'N', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '已撤销');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (40, '000000', 2, '草稿', 'draft', 'wf_business_status', '', 'info', 'N', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '草稿');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (41, '000000', 3, '待审核', 'waiting', 'wf_business_status', '', 'primary', 'N', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '待审核');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (42, '000000', 4, '已完成', 'finish', 'wf_business_status', '', 'success', 'N', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '已完成');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (43, '000000', 5, '已作废', 'invalid', 'wf_business_status', '', 'danger', 'N', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '已作废');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (44, '000000', 6, '已退回', 'back', 'wf_business_status', '', 'danger', 'N', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '已退回');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (45, '000000', 7, '已终止', 'termination', 'wf_business_status', '', 'danger', 'N', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '已终止');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (46, '000000', 1, '自定义表单', 'static', 'wf_form_type', '', 'success', 'N', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '自定义表单');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (47, '000000', 2, '动态表单', 'dynamic', 'wf_form_type', '', 'primary', 'N', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '动态表单');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (48, '000000', 1, '撤销', 'cancel', 'wf_task_status', '', 'danger', 'N', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '撤销');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (49, '000000', 2, '通过', 'pass', 'wf_task_status', '', 'success', 'N', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '通过');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (50, '000000', 3, '待审核', 'waiting', 'wf_task_status', '', 'primary', 'N', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '待审核');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (51, '000000', 4, '作废', 'invalid', 'wf_task_status', '', 'danger', 'N', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '作废');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (52, '000000', 5, '退回', 'back', 'wf_task_status', '', 'danger', 'N', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '退回');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (53, '000000', 6, '终止', 'termination', 'wf_task_status', '', 'danger', 'N', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '终止');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (54, '000000', 7, '转办', 'transfer', 'wf_task_status', '', 'primary', 'N', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '转办');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (55, '000000', 8, '委托', 'depute', 'wf_task_status', '', 'primary', 'N', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '委托');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (56, '000000', 9, '抄送', 'copy', 'wf_task_status', '', 'primary', 'N', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '抄送');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (57, '000000', 10, '加签', 'sign', 'wf_task_status', '', 'primary', 'N', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '加签');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (58, '000000', 11, '减签', 'sign_off', 'wf_task_status', '', 'danger', 'N', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '减签');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (59, '000000', 11, '超时', 'timeout', 'wf_task_status', '', 'danger', 'N', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '超时');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1001, '000000', 1, '学术研究', 'academic', 'hit_project_type', '', 'primary', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '学术研究项目');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1002, '000000', 2, '竞赛项目', 'competition', 'hit_project_type', '', 'success', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '各类竞赛项目');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1003, '000000', 3, '社会实践', 'practice', 'hit_project_type', '', 'info', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '社会实践项目');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1004, '000000', 4, '毕业设计', 'graduation', 'hit_project_type', '', 'warning', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '毕业设计项目');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1005, '000000', 5, '课程项目', 'course', 'hit_project_type', '', 'default', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '课程相关项目');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1011, '000000', 1, '计算机科学', 'computer', 'hit_project_category', '', 'primary', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '计算机科学与技术');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1012, '000000', 2, '电子信息', 'electronic', 'hit_project_category', '', 'success', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '电子信息工程');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1013, '000000', 3, '机械工程', 'mechanical', 'hit_project_category', '', 'info', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '机械工程');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1014, '000000', 4, '材料科学', 'material', 'hit_project_category', '', 'warning', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '材料科学与工程');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1015, '000000', 5, '土木工程', 'civil', 'hit_project_category', '', 'default', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '土木工程');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1016, '000000', 6, '生物医学', 'biomedical', 'hit_project_category', '', 'danger', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '生物医学工程');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1017, '000000', 7, '航空航天', 'aerospace', 'hit_project_category', '', 'primary', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '航空航天工程');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1018, '000000', 8, '能源动力', 'energy', 'hit_project_category', '', 'success', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '能源与动力工程');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1021, '000000', 1, '入门级', '1', 'hit_difficulty_level', '', 'success', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '适合初学者的简单项目');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1022, '000000', 2, '进阶级', '2', 'hit_difficulty_level', '', 'info', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '需要一定基础的项目');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1023, '000000', 3, '专业级', '3', 'hit_difficulty_level', '', 'warning', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '需要专业技能的项目');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1024, '000000', 4, '挑战级', '4', 'hit_difficulty_level', '', 'danger', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '高难度挑战性项目');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1031, '000000', 1, '短期项目', 'short', 'hit_duration_type', '', 'success', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '1-3个月的短期项目');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1032, '000000', 2, '中期项目', 'medium', 'hit_duration_type', '', 'info', 'Y', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '3-6个月的中期项目');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1033, '000000', 3, '长期项目', 'long', 'hit_duration_type', '', 'warning', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '6个月以上的长期项目');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1041, '000000', 1, '招募中', 'recruiting', 'hit_project_status', '', 'primary', 'Y', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '正在招募成员');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1042, '000000', 2, '进行中', 'ongoing', 'hit_project_status', '', 'info', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '项目正在进行');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1043, '000000', 3, '已完成', 'completed', 'hit_project_status', '', 'success', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '项目已完成');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1044, '000000', 4, '已暂停', 'paused', 'hit_project_status', '', 'warning', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '项目暂停');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1045, '000000', 5, '已取消', 'cancelled', 'hit_project_status', '', 'danger', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '项目已取消');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1051, '000000', 1, '开放招募', 'open', 'hit_recruitment_status', '', 'success', 'Y', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '正在开放招募');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1052, '000000', 2, '暂停招募', 'paused', 'hit_recruitment_status', '', 'warning', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '暂停招募');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1053, '000000', 3, '停止招募', 'closed', 'hit_recruitment_status', '', 'danger', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '停止招募');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1061, '000000', 1, '公开', 'public', 'hit_project_visibility', '', 'success', 'Y', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '所有人可见');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1062, '000000', 2, '校内可见', 'internal', 'hit_project_visibility', '', 'info', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '仅校内用户可见');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1063, '000000', 3, '私有', 'private', 'hit_project_visibility', '', 'warning', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '仅成员可见');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1071, '000000', 1, '自动通过', 'auto', 'hit_approval_mode', '', 'success', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '申请自动通过');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1072, '000000', 2, '手动审核', 'manual', 'hit_approval_mode', '', 'info', 'Y', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '需要手动审核');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1081, '000000', 1, '待审核', 'pending', 'hit_application_status', '', 'info', 'Y', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '等待审核');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1082, '000000', 2, '审核中', 'reviewing', 'hit_application_status', '', 'primary', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '正在审核');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1083, '000000', 3, '已通过', 'approved', 'hit_application_status', '', 'success', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '审核通过');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1084, '000000', 4, '已拒绝', 'rejected', 'hit_application_status', '', 'danger', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '审核拒绝');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1085, '000000', 5, '已撤回', 'withdrawn', 'hit_application_status', '', 'warning', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '申请撤回');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1091, '000000', 1, '活跃', 'active', 'hit_member_status', '', 'success', 'Y', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '成员活跃状态');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1092, '000000', 2, '不活跃', 'inactive', 'hit_member_status', '', 'warning', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '成员不活跃');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1093, '000000', 3, '已离开', 'left', 'hit_member_status', '', 'danger', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '成员已离开');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1101, '000000', 1, '教授', 'professor', 'hit_mentor_title', '', 'danger', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '教授');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1102, '000000', 2, '副教授', 'associate_professor', 'hit_mentor_title', '', 'warning', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '副教授');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1103, '000000', 3, '讲师', 'lecturer', 'hit_mentor_title', '', 'info', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '讲师');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1104, '000000', 4, '助理教授', 'assistant_professor', 'hit_mentor_title', '', 'primary', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '助理教授');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1105, '000000', 5, '研究员', 'researcher', 'hit_mentor_title', '', 'success', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '研究员');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1106, '000000', 6, '副研究员', 'associate_researcher', 'hit_mentor_title', '', 'default', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '副研究员');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1111, '000000', 1, '计算机科学与技术学院', 'computer_science', 'hit_college', '', 'primary', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '计算机科学与技术学院');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1112, '000000', 2, '电子与信息工程学院', 'electronic_information', 'hit_college', '', 'success', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '电子与信息工程学院');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1113, '000000', 3, '机电工程学院', 'mechanical_electrical', 'hit_college', '', 'info', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '机电工程学院');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1114, '000000', 4, '材料科学与工程学院', 'materials_science', 'hit_college', '', 'warning', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '材料科学与工程学院');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1115, '000000', 5, '土木工程学院', 'civil_engineering', 'hit_college', '', 'default', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '土木工程学院');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1116, '000000', 6, '航天学院', 'aerospace', 'hit_college', '', 'danger', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '航天学院');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1117, '000000', 7, '能源科学与工程学院', 'energy_science', 'hit_college', '', 'primary', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '能源科学与工程学院');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1118, '000000', 8, '经济与管理学院', 'economics_management', 'hit_college', '', 'success', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '经济与管理学院');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1119, '000000', 9, '人文社科与法学学院', 'humanities_law', 'hit_college', '', 'info', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '人文社科与法学学院');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1120, '000000', 10, '外国语学院', 'foreign_languages', 'hit_college', '', 'warning', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '外国语学院');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1121, '000000', 1, '大一', 'freshman', 'hit_grade', '', 'success', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '大学一年级');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1122, '000000', 2, '大二', 'sophomore', 'hit_grade', '', 'info', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '大学二年级');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1123, '000000', 3, '大三', 'junior', 'hit_grade', '', 'warning', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '大学三年级');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1124, '000000', 4, '大四', 'senior', 'hit_grade', '', 'danger', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '大学四年级');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1125, '000000', 5, '研一', 'graduate_1', 'hit_grade', '', 'primary', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '研究生一年级');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1126, '000000', 6, '研二', 'graduate_2', 'hit_grade', '', 'primary', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '研究生二年级');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1127, '000000', 7, '研三', 'graduate_3', 'hit_grade', '', 'primary', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '研究生三年级');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1128, '000000', 8, '博一', 'phd_1', 'hit_grade', '', 'default', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '博士一年级');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1129, '000000', 9, '博二', 'phd_2', 'hit_grade', '', 'default', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '博士二年级');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1130, '000000', 10, '博三', 'phd_3', 'hit_grade', '', 'default', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '博士三年级');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1131, '000000', 11, '博四', 'phd_4', 'hit_grade', '', 'default', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '博士四年级');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1141, '000000', 1, '了解', '1', 'hit_skill_level', '', 'default', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '基本了解');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1142, '000000', 2, '熟悉', '2', 'hit_skill_level', '', 'info', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '比较熟悉');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1143, '000000', 3, '熟练', '3', 'hit_skill_level', '', 'primary', 'Y', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '熟练掌握');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1144, '000000', 4, '精通', '4', 'hit_skill_level', '', 'warning', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '精通专业');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1145, '000000', 5, '专家', '5', 'hit_skill_level', '', 'danger', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '专家级别');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1151, '000000', 1, '项目作品', 'project', 'hit_work_type', '', 'primary', 'Y', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '软件项目作品');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1152, '000000', 2, '设计作品', 'design', 'hit_work_type', '', 'success', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, 'UI/UX设计作品');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1153, '000000', 3, '学术成果', 'academic', 'hit_work_type', '', 'info', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '学术论文成果');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1154, '000000', 4, '媒体作品', 'media', 'hit_work_type', '', 'warning', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '视频音频作品');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1161, '000000', 1, '功能开发', 'feature', 'hit_task_type', '', 'primary', 'Y', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '新功能开发');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1162, '000000', 2, '问题修复', 'bug', 'hit_task_type', '', 'danger', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, 'Bug修复');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1163, '000000', 3, '性能优化', 'optimization', 'hit_task_type', '', 'warning', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '性能优化');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1164, '000000', 4, '测试任务', 'test', 'hit_task_type', '', 'info', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '测试相关任务');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1171, '000000', 1, '低', 'low', 'hit_task_priority', '', 'default', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '低优先级');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1172, '000000', 2, '中', 'medium', 'hit_task_priority', '', 'info', 'Y', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '中等优先级');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1173, '000000', 3, '高', 'high', 'hit_task_priority', '', 'warning', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '高优先级');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1174, '000000', 4, '紧急', 'urgent', 'hit_task_priority', '', 'danger', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '紧急优先级');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1181, '000000', 1, '待开始', 'todo', 'hit_task_status', '', 'default', 'Y', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '待开始任务');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1182, '000000', 2, '进行中', 'doing', 'hit_task_status', '', 'primary', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '正在进行');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1183, '000000', 3, '测试中', 'testing', 'hit_task_status', '', 'info', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '测试阶段');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1184, '000000', 4, '已完成', 'done', 'hit_task_status', '', 'success', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '任务完成');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1185, '000000', 5, '已取消', 'cancelled', 'hit_task_status', '', 'danger', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '任务取消');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1191, '000000', 1, '待开始', 'pending', 'hit_milestone_status', '', 'default', 'Y', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '待开始');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1192, '000000', 2, '进行中', 'in_progress', 'hit_milestone_status', '', 'primary', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '进行中');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1193, '000000', 3, '已完成', 'completed', 'hit_milestone_status', '', 'success', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '已完成');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1194, '000000', 4, '已延期', 'delayed', 'hit_milestone_status', '', 'danger', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '已延期');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1201, '000000', 1, '申请通知', 'application', 'hit_notification_type', '', 'primary', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '项目申请相关通知');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1202, '000000', 2, '审核通知', 'approval', 'hit_notification_type', '', 'info', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '审核结果通知');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1203, '000000', 3, '项目更新', 'project_update', 'hit_notification_type', '', 'success', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '项目信息更新');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1204, '000000', 4, '任务分配', 'task_assign', 'hit_notification_type', '', 'warning', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '任务分配通知');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1205, '000000', 5, '系统通知', 'system', 'hit_notification_type', '', 'default', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '系统公告通知');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1211, '000000', 1, '低', 'low', 'hit_notification_priority', '', 'default', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '低优先级通知');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1212, '000000', 2, '普通', 'normal', 'hit_notification_priority', '', 'info', 'Y', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '普通优先级通知');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1213, '000000', 3, '高', 'high', 'hit_notification_priority', '', 'warning', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '高优先级通知');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1214, '000000', 4, '紧急', 'urgent', 'hit_notification_priority', '', 'danger', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '紧急通知');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1221, '000000', 1, '站内消息', 'system', 'hit_notification_channel', '', 'primary', 'Y', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '系统内消息');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1222, '000000', 2, '邮件通知', 'email', 'hit_notification_channel', '', 'info', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '邮件通知');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1223, '000000', 3, '短信通知', 'sms', 'hit_notification_channel', '', 'warning', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '短信通知');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1224, '000000', 4, '微信通知', 'wechat', 'hit_notification_channel', '', 'success', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '微信小程序通知');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1231, '000000', 1, '关注用户', 'user', 'hit_follow_type', '', 'primary', 'Y', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '关注普通用户');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1232, '000000', 2, '关注导师', 'mentor', 'hit_follow_type', '', 'warning', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '关注导师');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1241, '000000', 1, '团队成员', 'member', 'hit_evaluator_type', '', 'primary', 'Y', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '团队成员评价');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1242, '000000', 2, '指导导师', 'mentor', 'hit_evaluator_type', '', 'warning', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '导师评价');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1243, '000000', 3, '同行评价', 'peer', 'hit_evaluator_type', '', 'info', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '同行评价');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1251, '000000', 1, '中期评价', 'midterm', 'hit_evaluation_phase', '', 'info', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '项目中期评价');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1252, '000000', 2, '最终评价', 'final', 'hit_evaluation_phase', '', 'primary', 'Y', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '项目最终评价');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1253, '000000', 3, '后续评价', 'post', 'hit_evaluation_phase', '', 'success', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '项目结束后评价');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1261, '000000', 1, '感兴趣', 'interested', 'hit_collection_type', '', 'info', 'Y', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '对项目感兴趣');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1262, '000000', 2, '已申请', 'applied', 'hit_collection_type', '', 'warning', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '已申请加入');
INSERT INTO `sys_dict_data` (`dict_code`, `tenant_id`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1263, '000000', 3, '关注中', 'following', 'hit_collection_type', '', 'primary', 'N', 103, 1, '2025-08-11 16:34:43', NULL, NULL, '持续关注');
COMMIT;

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
BEGIN;
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '000000', '用户性别', 'sys_user_sex', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '用户性别列表');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '000000', '菜单状态', 'sys_show_hide', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, '000000', '系统开关', 'sys_normal_disable', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '系统开关列表');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (6, '000000', '系统是否', 'sys_yes_no', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '系统是否列表');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (7, '000000', '通知类型', 'sys_notice_type', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '通知类型列表');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (8, '000000', '通知状态', 'sys_notice_status', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '通知状态列表');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (9, '000000', '操作类型', 'sys_oper_type', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '操作类型列表');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (10, '000000', '系统状态', 'sys_common_status', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '登录状态列表');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (11, '000000', '授权类型', 'sys_grant_type', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '认证授权类型');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (12, '000000', '设备类型', 'sys_device_type', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '客户端设备类型');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (13, '000000', '业务状态', 'wf_business_status', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '业务状态列表');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (14, '000000', '表单类型', 'wf_form_type', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '表单类型列表');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (15, '000000', '任务状态', 'wf_task_status', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '任务状态');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (100, '000000', '项目类型', 'hit_project_type', 103, 1, '2025-08-11 16:34:42', NULL, NULL, 'HIT项目组队通项目类型字典');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (101, '000000', '项目分类', 'hit_project_category', 103, 1, '2025-08-11 16:34:42', NULL, NULL, 'HIT项目组队通项目分类字典');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (102, '000000', '难度等级', 'hit_difficulty_level', 103, 1, '2025-08-11 16:34:42', NULL, NULL, 'HIT项目组队通难度等级字典');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (103, '000000', '项目周期类型', 'hit_duration_type', 103, 1, '2025-08-11 16:34:42', NULL, NULL, 'HIT项目组队通项目周期类型字典');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (104, '000000', '项目状态', 'hit_project_status', 103, 1, '2025-08-11 16:34:42', NULL, NULL, 'HIT项目组队通项目状态字典');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (105, '000000', '招募状态', 'hit_recruitment_status', 103, 1, '2025-08-11 16:34:42', NULL, NULL, 'HIT项目组队通招募状态字典');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (106, '000000', '项目可见性', 'hit_project_visibility', 103, 1, '2025-08-11 16:34:42', NULL, NULL, 'HIT项目组队通项目可见性字典');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (107, '000000', '审核模式', 'hit_approval_mode', 103, 1, '2025-08-11 16:34:42', NULL, NULL, 'HIT项目组队通审核模式字典');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (108, '000000', '申请状态', 'hit_application_status', 103, 1, '2025-08-11 16:34:42', NULL, NULL, 'HIT项目组队通申请状态字典');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (109, '000000', '成员状态', 'hit_member_status', 103, 1, '2025-08-11 16:34:42', NULL, NULL, 'HIT项目组队通成员状态字典');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (110, '000000', '导师职称', 'hit_mentor_title', 103, 1, '2025-08-11 16:34:42', NULL, NULL, 'HIT项目组队通导师职称字典');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (111, '000000', '学院', 'hit_college', 103, 1, '2025-08-11 16:34:42', NULL, NULL, 'HIT项目组队通学院字典');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (112, '000000', '年级', 'hit_grade', 103, 1, '2025-08-11 16:34:42', NULL, NULL, 'HIT项目组队通年级字典');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (113, '000000', '技能等级', 'hit_skill_level', 103, 1, '2025-08-11 16:34:42', NULL, NULL, 'HIT项目组队通技能等级字典');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (114, '000000', '作品类型', 'hit_work_type', 103, 1, '2025-08-11 16:34:42', NULL, NULL, 'HIT项目组队通作品类型字典');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (115, '000000', '任务类型', 'hit_task_type', 103, 1, '2025-08-11 16:34:42', NULL, NULL, 'HIT项目组队通任务类型字典');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (116, '000000', '任务优先级', 'hit_task_priority', 103, 1, '2025-08-11 16:34:42', NULL, NULL, 'HIT项目组队通任务优先级字典');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (117, '000000', '任务状态', 'hit_task_status', 103, 1, '2025-08-11 16:34:42', NULL, NULL, 'HIT项目组队通任务状态字典');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (118, '000000', '里程碑状态', 'hit_milestone_status', 103, 1, '2025-08-11 16:34:42', NULL, NULL, 'HIT项目组队通里程碑状态字典');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (119, '000000', '通知类型', 'hit_notification_type', 103, 1, '2025-08-11 16:34:42', NULL, NULL, 'HIT项目组队通通知类型字典');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (120, '000000', '通知优先级', 'hit_notification_priority', 103, 1, '2025-08-11 16:34:42', NULL, NULL, 'HIT项目组队通通知优先级字典');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (121, '000000', '通知渠道', 'hit_notification_channel', 103, 1, '2025-08-11 16:34:42', NULL, NULL, 'HIT项目组队通通知渠道字典');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (122, '000000', '关注类型', 'hit_follow_type', 103, 1, '2025-08-11 16:34:42', NULL, NULL, 'HIT项目组队通关注类型字典');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (123, '000000', '评价人类型', 'hit_evaluator_type', 103, 1, '2025-08-11 16:34:43', NULL, NULL, 'HIT项目组队通评价人类型字典');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (124, '000000', '评价阶段', 'hit_evaluation_phase', 103, 1, '2025-08-11 16:34:43', NULL, NULL, 'HIT项目组队通评价阶段字典');
INSERT INTO `sys_dict_type` (`dict_id`, `tenant_id`, `dict_name`, `dict_type`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (125, '000000', '收藏类型', 'hit_collection_type', 103, 1, '2025-08-11 16:34:43', NULL, NULL, 'HIT项目组队通收藏类型字典');
COMMIT;

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
BEGIN;
INSERT INTO `sys_logininfor` (`info_id`, `tenant_id`, `user_name`, `client_key`, `device_type`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (1953827752346193922, '000000', '18878688656', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'MicroMessenger', 'iPhone', '0', '登录成功', '2025-08-08 22:36:51');
INSERT INTO `sys_logininfor` (`info_id`, `tenant_id`, `user_name`, `client_key`, `device_type`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (1954819907368013825, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-08-11 16:19:19');
INSERT INTO `sys_logininfor` (`info_id`, `tenant_id`, `user_name`, `client_key`, `device_type`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (1954931136709107713, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'OSX', '0', '登录成功', '2025-08-11 23:41:19');
INSERT INTO `sys_logininfor` (`info_id`, `tenant_id`, `user_name`, `client_key`, `device_type`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (1955067941974458369, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'OSX', '0', '登录成功', '2025-08-12 08:44:55');
INSERT INTO `sys_logininfor` (`info_id`, `tenant_id`, `user_name`, `client_key`, `device_type`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (1955111478623539201, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'OSX', '0', '登录成功', '2025-08-12 11:37:55');
INSERT INTO `sys_logininfor` (`info_id`, `tenant_id`, `user_name`, `client_key`, `device_type`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (1955159848285179905, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'OSX', '0', '登录成功', '2025-08-12 14:50:08');
INSERT INTO `sys_logininfor` (`info_id`, `tenant_id`, `user_name`, `client_key`, `device_type`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (1955259667448119297, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'OSX', '0', '登录成功', '2025-08-12 21:26:46');
INSERT INTO `sys_logininfor` (`info_id`, `tenant_id`, `user_name`, `client_key`, `device_type`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (1955531402269470721, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'OSX', '0', '登录成功', '2025-08-13 15:26:33');
INSERT INTO `sys_logininfor` (`info_id`, `tenant_id`, `user_name`, `client_key`, `device_type`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (1955603541743915009, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'OSX', '0', '登录成功', '2025-08-13 20:13:12');
INSERT INTO `sys_logininfor` (`info_id`, `tenant_id`, `user_name`, `client_key`, `device_type`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (1955611476205252610, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'OSX', '0', '退出成功', '2025-08-13 20:44:44');
INSERT INTO `sys_logininfor` (`info_id`, `tenant_id`, `user_name`, `client_key`, `device_type`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (1955611515673653249, '000000', 'zhangsan', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'OSX', '0', '登录成功', '2025-08-13 20:44:53');
INSERT INTO `sys_logininfor` (`info_id`, `tenant_id`, `user_name`, `client_key`, `device_type`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (1955612104323248129, '000000', 'zhangsan', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'OSX', '0', '退出成功', '2025-08-13 20:47:14');
INSERT INTO `sys_logininfor` (`info_id`, `tenant_id`, `user_name`, `client_key`, `device_type`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (1955612138955616257, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'OSX', '0', '登录成功', '2025-08-13 20:47:22');
INSERT INTO `sys_logininfor` (`info_id`, `tenant_id`, `user_name`, `client_key`, `device_type`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (1955621127399473154, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'OSX', '0', '登录成功', '2025-08-13 21:23:05');
INSERT INTO `sys_logininfor` (`info_id`, `tenant_id`, `user_name`, `client_key`, `device_type`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (1955904878545264641, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'OSX', '0', '登录成功', '2025-08-14 16:10:37');
INSERT INTO `sys_logininfor` (`info_id`, `tenant_id`, `user_name`, `client_key`, `device_type`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (1955907359874539521, '000000', 'zhangsan', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'OSX', '0', '登录成功', '2025-08-14 16:20:28');
INSERT INTO `sys_logininfor` (`info_id`, `tenant_id`, `user_name`, `client_key`, `device_type`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (1955931313150414849, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'OSX', '0', '登录成功', '2025-08-14 17:55:39');
INSERT INTO `sys_logininfor` (`info_id`, `tenant_id`, `user_name`, `client_key`, `device_type`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (1955933003371040770, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'OSX', '0', '登录成功', '2025-08-14 18:02:22');
INSERT INTO `sys_logininfor` (`info_id`, `tenant_id`, `user_name`, `client_key`, `device_type`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (1955953393329819649, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'OSX', '1', '验证码已失效', '2025-08-14 19:23:23');
INSERT INTO `sys_logininfor` (`info_id`, `tenant_id`, `user_name`, `client_key`, `device_type`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (1955953452565975042, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'OSX', '0', '登录成功', '2025-08-14 19:23:38');
INSERT INTO `sys_logininfor` (`info_id`, `tenant_id`, `user_name`, `client_key`, `device_type`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (1955953472593776642, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'OSX', '0', '登录成功', '2025-08-14 19:23:42');
INSERT INTO `sys_logininfor` (`info_id`, `tenant_id`, `user_name`, `client_key`, `device_type`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (1955992432216961025, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'OSX', '0', '登录成功', '2025-08-14 21:58:31');
INSERT INTO `sys_logininfor` (`info_id`, `tenant_id`, `user_name`, `client_key`, `device_type`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (1955999215597711362, '000000', 'zhangsan', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'OSX', '1', '验证码错误', '2025-08-14 22:25:28');
INSERT INTO `sys_logininfor` (`info_id`, `tenant_id`, `user_name`, `client_key`, `device_type`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (1955999233922625537, '000000', 'zhangsan', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'OSX', '0', '登录成功', '2025-08-14 22:25:33');
INSERT INTO `sys_logininfor` (`info_id`, `tenant_id`, `user_name`, `client_key`, `device_type`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (1956009969310789633, '000000', 'zhangsan', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'OSX', '0', '登录成功', '2025-08-14 23:08:12');
INSERT INTO `sys_logininfor` (`info_id`, `tenant_id`, `user_name`, `client_key`, `device_type`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (1956267308530081794, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'OSX', '0', '登录成功', '2025-08-15 16:10:47');
INSERT INTO `sys_logininfor` (`info_id`, `tenant_id`, `user_name`, `client_key`, `device_type`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (1956267695278465026, '000000', 'zhangsan', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'OSX', '0', '登录成功', '2025-08-15 16:12:19');
INSERT INTO `sys_logininfor` (`info_id`, `tenant_id`, `user_name`, `client_key`, `device_type`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (1956280994002968578, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'OSX', '0', '登录成功', '2025-08-15 17:05:10');
INSERT INTO `sys_logininfor` (`info_id`, `tenant_id`, `user_name`, `client_key`, `device_type`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (1956281133660708865, '000000', 'zhangsan', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'OSX', '0', '登录成功', '2025-08-15 17:05:43');
INSERT INTO `sys_logininfor` (`info_id`, `tenant_id`, `user_name`, `client_key`, `device_type`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (1956290870347374593, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'OSX', '0', '登录成功', '2025-08-15 17:44:24');
INSERT INTO `sys_logininfor` (`info_id`, `tenant_id`, `user_name`, `client_key`, `device_type`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (1956290957052026882, '000000', 'zhangsan', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'OSX', '0', '登录成功', '2025-08-15 17:44:45');
INSERT INTO `sys_logininfor` (`info_id`, `tenant_id`, `user_name`, `client_key`, `device_type`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (1956359002416009218, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'OSX', '0', '登录成功', '2025-08-15 22:15:08');
INSERT INTO `sys_logininfor` (`info_id`, `tenant_id`, `user_name`, `client_key`, `device_type`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (1956533764958269441, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'OSX', '0', '登录成功', '2025-08-16 09:49:35');
INSERT INTO `sys_logininfor` (`info_id`, `tenant_id`, `user_name`, `client_key`, `device_type`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (1956556572476071938, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'OSX', '0', '登录成功', '2025-08-16 11:20:13');
INSERT INTO `sys_logininfor` (`info_id`, `tenant_id`, `user_name`, `client_key`, `device_type`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (1956571454831353858, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'OSX', '0', '登录成功', '2025-08-16 12:19:21');
COMMIT;

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
BEGIN;
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '系统管理', 0, 1, 'system', NULL, '', 1, 0, 'M', '0', '0', '', 'system', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '系统管理目录');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '系统监控', 0, 3, 'monitor', NULL, '', 1, 0, 'M', '0', '1', '', 'monitor', 103, 1, '2025-08-08 13:49:43', 1, '2025-08-11 16:42:13', '系统监控目录');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, '系统工具', 0, 4, 'tool', NULL, '', 1, 0, 'M', '0', '0', '', 'tool', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '系统工具目录');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (5, '测试菜单', 0, 5, 'demo', NULL, '', 1, 0, 'M', '0', '1', '', 'star', 103, 1, '2025-08-08 13:49:43', 1, '2025-08-11 16:41:58', '测试菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (6, '租户管理', 0, 2, 'tenant', NULL, '', 1, 0, 'M', '0', '1', '', 'chart', 103, 1, '2025-08-08 13:49:43', 1, '2025-08-11 16:42:19', '租户管理目录');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '用户管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '角色管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '菜单管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '部门管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '岗位管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '字典管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '参数设置菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '通知公告菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (108, '日志管理', 1, 9, 'log', '', '', 1, 0, 'M', '0', '0', '', 'log', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '日志管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '在线用户菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '缓存监控菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (115, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '代码生成菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (116, '修改生成配置', 3, 2, 'gen-edit/index/:tableId', 'tool/gen/editTable', '', 1, 1, 'C', '1', '0', 'tool:gen:edit', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (117, 'Admin监控', 2, 5, 'Admin', 'monitor/admin/index', '', 1, 0, 'C', '0', '0', 'monitor:admin:list', 'dashboard', 103, 1, '2025-08-08 13:49:43', NULL, NULL, 'Admin监控菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (118, '文件管理', 1, 10, 'oss', 'system/oss/index', '', 1, 0, 'C', '0', '0', 'system:oss:list', 'upload', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '文件管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (120, '任务调度中心', 2, 6, 'snailjob', 'monitor/snailjob/index', '', 1, 0, 'C', '0', '0', 'monitor:snailjob:list', 'job', 103, 1, '2025-08-08 13:49:43', NULL, NULL, 'SnailJob控制台菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (121, '租户管理', 6, 1, 'tenant', 'system/tenant/index', '', 1, 0, 'C', '0', '0', 'system:tenant:list', 'list', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '租户管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (122, '租户套餐管理', 6, 2, 'tenantPackage', 'system/tenantPackage/index', '', 1, 0, 'C', '0', '0', 'system:tenantPackage:list', 'form', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '租户套餐管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (123, '客户端管理', 1, 11, 'client', 'system/client/index', '', 1, 0, 'C', '0', '0', 'system:client:list', 'international', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '客户端管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (130, '分配用户', 1, 2, 'role-auth/user/:roleId', 'system/role/authUser', '', 1, 1, 'C', '1', '0', 'system:role:edit', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (131, '分配角色', 1, 1, 'user-auth/role/:userId', 'system/user/authRole', '', 1, 1, 'C', '1', '0', 'system:user:edit', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (132, '字典数据', 1, 6, 'dict-data/index/:dictId', 'system/dict/data', '', 1, 1, 'C', '1', '0', 'system:dict:list', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (133, '文件配置管理', 1, 10, 'oss-config/index', 'system/oss/config', '', 1, 1, 'C', '1', '0', 'system:ossConfig:list', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '操作日志菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '登录日志菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1001, '用户查询', 100, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1002, '用户新增', 100, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1003, '用户修改', 100, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1004, '用户删除', 100, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1005, '用户导出', 100, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1006, '用户导入', 100, 6, '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1007, '重置密码', 100, 7, '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1008, '角色查询', 101, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1009, '角色新增', 101, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1010, '角色修改', 101, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1011, '角色删除', 101, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1012, '角色导出', 101, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1013, '菜单查询', 102, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1014, '菜单新增', 102, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1015, '菜单修改', 102, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1016, '菜单删除', 102, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1017, '部门查询', 103, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1018, '部门新增', 103, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1019, '部门修改', 103, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1020, '部门删除', 103, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1021, '岗位查询', 104, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1022, '岗位新增', 104, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1023, '岗位修改', 104, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1024, '岗位删除', 104, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1025, '岗位导出', 104, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1026, '字典查询', 105, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1027, '字典新增', 105, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1028, '字典修改', 105, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1029, '字典删除', 105, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1030, '字典导出', 105, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1031, '参数查询', 106, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1032, '参数新增', 106, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1033, '参数修改', 106, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1034, '参数删除', 106, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1035, '参数导出', 106, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1036, '公告查询', 107, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1037, '公告新增', 107, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1038, '公告修改', 107, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1039, '公告删除', 107, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1040, '操作查询', 500, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1041, '操作删除', 500, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1042, '日志导出', 500, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1043, '登录查询', 501, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1044, '登录删除', 501, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1045, '日志导出', 501, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1046, '在线查询', 109, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1047, '批量强退', 109, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1048, '单条强退', 109, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1050, '账户解锁', 501, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1055, '生成查询', 115, 1, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1056, '生成修改', 115, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1057, '生成删除', 115, 3, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1058, '导入代码', 115, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1059, '预览代码', 115, 4, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1060, '生成代码', 115, 5, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1061, '客户端管理查询', 123, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:client:query', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1062, '客户端管理新增', 123, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:client:add', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1063, '客户端管理修改', 123, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:client:edit', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1064, '客户端管理删除', 123, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:client:remove', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1065, '客户端管理导出', 123, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:client:export', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1500, '测试单表', 5, 1, 'demo', 'demo/demo/index', '', 1, 0, 'C', '0', '0', 'demo:demo:list', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '测试单表菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1501, '测试单表查询', 1500, 1, '#', '', '', 1, 0, 'F', '0', '0', 'demo:demo:query', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1502, '测试单表新增', 1500, 2, '#', '', '', 1, 0, 'F', '0', '0', 'demo:demo:add', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1503, '测试单表修改', 1500, 3, '#', '', '', 1, 0, 'F', '0', '0', 'demo:demo:edit', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1504, '测试单表删除', 1500, 4, '#', '', '', 1, 0, 'F', '0', '0', 'demo:demo:remove', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1505, '测试单表导出', 1500, 5, '#', '', '', 1, 0, 'F', '0', '0', 'demo:demo:export', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1506, '测试树表', 5, 1, 'tree', 'demo/tree/index', '', 1, 0, 'C', '0', '0', 'demo:tree:list', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '测试树表菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1507, '测试树表查询', 1506, 1, '#', '', '', 1, 0, 'F', '0', '0', 'demo:tree:query', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1508, '测试树表新增', 1506, 2, '#', '', '', 1, 0, 'F', '0', '0', 'demo:tree:add', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1509, '测试树表修改', 1506, 3, '#', '', '', 1, 0, 'F', '0', '0', 'demo:tree:edit', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1510, '测试树表删除', 1506, 4, '#', '', '', 1, 0, 'F', '0', '0', 'demo:tree:remove', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1511, '测试树表导出', 1506, 5, '#', '', '', 1, 0, 'F', '0', '0', 'demo:tree:export', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1600, '文件查询', 118, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:oss:query', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1601, '文件上传', 118, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:oss:upload', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1602, '文件下载', 118, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:oss:download', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1603, '文件删除', 118, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:oss:remove', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1606, '租户查询', 121, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenant:query', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1607, '租户新增', 121, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenant:add', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1608, '租户修改', 121, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenant:edit', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1609, '租户删除', 121, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenant:remove', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1610, '租户导出', 121, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenant:export', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1611, '租户套餐查询', 122, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenantPackage:query', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1612, '租户套餐新增', 122, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenantPackage:add', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1613, '租户套餐修改', 122, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenantPackage:edit', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1614, '租户套餐删除', 122, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenantPackage:remove', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1615, '租户套餐导出', 122, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:tenantPackage:export', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1620, '配置列表', 118, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:ossConfig:list', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1621, '配置添加', 118, 6, '#', '', '', 1, 0, 'F', '0', '0', 'system:ossConfig:add', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1622, '配置编辑', 118, 6, '#', '', '', 1, 0, 'F', '0', '0', 'system:ossConfig:edit', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1623, '配置删除', 118, 6, '#', '', '', 1, 0, 'F', '0', '0', 'system:ossConfig:remove', '#', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2001, '个人名片', 0, 6, 'profile', NULL, '', 1, 0, 'M', '0', '0', '', 'user', 103, 1, '2025-08-11 14:26:57', NULL, NULL, '个人名片功能菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2002, '个人档案', 2001, 1, 'userProfile', 'hit/userProfile/index', '', 1, 0, 'C', '0', '0', 'hit:userProfile:list', 'peoples', 103, 1, '2025-08-11 14:26:57', NULL, NULL, '个人档案管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2003, '技能管理', 2001, 2, 'userSkill', 'hit/userSkill/index', '', 1, 0, 'C', '0', '0', 'hit:userSkill:list', 'skill', 103, 1, '2025-08-11 14:26:57', NULL, NULL, '技能管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2004, '作品集管理', 2001, 3, 'userPortfolio', 'hit/userPortfolio/index', '', 1, 0, 'C', '0', '0', 'hit:userPortfolio:list', 'documentation', 103, 1, '2025-08-11 14:26:57', NULL, NULL, '作品集管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2005, '技能标签', 2001, 4, 'skillTag', 'hit/skillTag/index', '', 1, 0, 'C', '0', '0', 'hit:skillTag:list', 'finish', 103, 1, '2025-08-11 14:26:57', 1, '2025-08-12 16:19:23', '技能标签管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2006, '名片展示', 2001, 5, 'profileCard', 'hit/profileCard/index', '', 1, 0, 'C', '0', '0', 'hit:profileCard:view', 'people', 103, 1, '2025-08-11 14:26:57', 1, '2025-08-12 16:19:48', '名片展示菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2011, '个人档案查询', 2002, 1, '', '', '', 1, 0, 'F', '0', '0', 'hit:userProfile:query', '', 103, 1, '2025-08-11 14:26:57', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2012, '个人档案新增', 2002, 2, '', '', '', 1, 0, 'F', '0', '0', 'hit:userProfile:add', '', 103, 1, '2025-08-11 14:26:57', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2013, '个人档案修改', 2002, 3, '', '', '', 1, 0, 'F', '0', '0', 'hit:userProfile:edit', '', 103, 1, '2025-08-11 14:26:57', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2014, '个人档案删除', 2002, 4, '', '', '', 1, 0, 'F', '0', '0', 'hit:userProfile:remove', '', 103, 1, '2025-08-11 14:26:57', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2015, '个人档案导出', 2002, 5, '', '', '', 1, 0, 'F', '0', '0', 'hit:userProfile:export', '', 103, 1, '2025-08-11 14:26:57', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2021, '技能管理查询', 2003, 1, '', '', '', 1, 0, 'F', '0', '0', 'hit:userSkill:query', '', 103, 1, '2025-08-11 14:26:57', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2022, '技能管理新增', 2003, 2, '', '', '', 1, 0, 'F', '0', '0', 'hit:userSkill:add', '', 103, 1, '2025-08-11 14:26:57', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2023, '技能管理修改', 2003, 3, '', '', '', 1, 0, 'F', '0', '0', 'hit:userSkill:edit', '', 103, 1, '2025-08-11 14:26:57', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2024, '技能管理删除', 2003, 4, '', '', '', 1, 0, 'F', '0', '0', 'hit:userSkill:remove', '', 103, 1, '2025-08-11 14:26:57', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2025, '技能管理导出', 2003, 5, '', '', '', 1, 0, 'F', '0', '0', 'hit:userSkill:export', '', 103, 1, '2025-08-11 14:26:57', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2031, '作品集查询', 2004, 1, '', '', '', 1, 0, 'F', '0', '0', 'hit:userPortfolio:query', '', 103, 1, '2025-08-11 14:26:57', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2032, '作品集新增', 2004, 2, '', '', '', 1, 0, 'F', '0', '0', 'hit:userPortfolio:add', '', 103, 1, '2025-08-11 14:26:57', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2033, '作品集修改', 2004, 3, '', '', '', 1, 0, 'F', '0', '0', 'hit:userPortfolio:edit', '', 103, 1, '2025-08-11 14:26:57', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2034, '作品集删除', 2004, 4, '', '', '', 1, 0, 'F', '0', '0', 'hit:userPortfolio:remove', '', 103, 1, '2025-08-11 14:26:57', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2035, '作品集导出', 2004, 5, '', '', '', 1, 0, 'F', '0', '0', 'hit:userPortfolio:export', '', 103, 1, '2025-08-11 14:26:57', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2041, '技能标签查询', 2005, 1, '', '', '', 1, 0, 'F', '0', '0', 'hit:skillTag:query', '', 103, 1, '2025-08-11 14:26:57', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2042, '技能标签新增', 2005, 2, '', '', '', 1, 0, 'F', '0', '0', 'hit:skillTag:add', '', 103, 1, '2025-08-11 14:26:57', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2043, '技能标签修改', 2005, 3, '', '', '', 1, 0, 'F', '0', '0', 'hit:skillTag:edit', '', 103, 1, '2025-08-11 14:26:57', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2044, '技能标签删除', 2005, 4, '', '', '', 1, 0, 'F', '0', '0', 'hit:skillTag:remove', '', 103, 1, '2025-08-11 14:26:57', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2045, '技能标签导出', 2005, 5, '', '', '', 1, 0, 'F', '0', '0', 'hit:skillTag:export', '', 103, 1, '2025-08-11 14:26:57', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2051, '名片查看', 2006, 1, '', '', '', 1, 0, 'F', '0', '0', 'hit:profileCard:view', '', 103, 1, '2025-08-11 14:26:57', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2052, '名片分享', 2006, 2, '', '', '', 1, 0, 'F', '0', '0', 'hit:profileCard:share', '', 103, 1, '2025-08-11 14:26:57', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2053, '名片导出', 2006, 3, '', '', '', 1, 0, 'F', '0', '0', 'hit:profileCard:export', '', 103, 1, '2025-08-11 14:26:57', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3000, 'HIT项目', 0, 0, 'hit', 'Layout', '', 1, 0, 'M', '0', '0', '', 'category', 103, 1, '2025-08-12 13:43:01', 1, '2025-08-12 14:03:02', 'HIT项目管理模块');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3001, '项目广场', 3000, 1, 'project', 'hit/project/index', '', 1, 0, 'C', '0', '0', 'hit:project:list', 'list', 103, 1, '2025-08-12 13:43:01', NULL, NULL, '项目广场菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3002, '我的项目', 3000, 2, 'project/my', 'hit/project/my', '', 1, 0, 'C', '0', '0', 'hit:project:my', 'build', 103, 1, '2025-08-12 13:43:01', 1, '2025-08-14 16:11:05', '我的项目管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3007, '项目详情', 3000, 1, 'project/detail/:id', 'hit/project/detail', '', 1, 1, 'C', '1', '0', 'hit:project:detail', '#', 103, 1, '2025-08-12 13:43:01', NULL, '2025-08-12 14:03:02', '项目详情页面');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3008, '创建项目', 3000, 2, 'project/create', 'hit/project/create', '', 1, 1, 'C', '1', '0', 'hit:project:add', '#', 103, 1, '2025-08-12 13:43:01', NULL, '2025-08-12 14:03:02', '创建项目页面');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3009, '编辑项目', 3000, 1, 'project/edit/:id', 'hit/project/edit', '', 1, 1, 'C', '1', '0', 'hit:project:edit', '#', 103, 1, '2025-08-12 13:43:01', NULL, '2025-08-12 14:03:02', '编辑项目页面');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3010, '申请管理', 3000, 2, 'project/applications/:id', 'hit/project/applications', '', 1, 1, 'C', '1', '0', 'hit:project:applications', '#', 103, 1, '2025-08-12 13:43:01', NULL, '2025-08-12 14:03:02', '项目申请管理页面');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3011, '成员管理', 3000, 3, 'project/members/:id', 'hit/project/members', '', 1, 1, 'C', '1', '0', 'hit:project:members', '#', 103, 1, '2025-08-12 13:57:26', NULL, '2025-08-12 14:03:02', '项目成员管理页面');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3012, '申请加入项目', 3000, 4, 'project/apply/:id', 'hit/project/apply', '', 1, 1, 'C', '1', '0', 'hit:project:apply', '#', 103, 1, '2025-08-13 13:39:43', NULL, NULL, '申请加入项目页面');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3101, '项目查询', 3001, 1, '', '', '', 1, 0, 'F', '0', '0', 'hit:project:query', '#', 103, 1, '2025-08-12 13:43:01', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3102, '项目新增', 3001, 2, '', '', '', 1, 0, 'F', '0', '0', 'hit:project:add', '#', 103, 1, '2025-08-12 13:43:01', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3103, '项目修改', 3001, 3, '', '', '', 1, 0, 'F', '0', '0', 'hit:project:edit', '#', 103, 1, '2025-08-12 13:43:01', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3104, '项目删除', 3001, 4, '', '', '', 1, 0, 'F', '0', '0', 'hit:project:remove', '#', 103, 1, '2025-08-12 13:43:01', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3105, '项目导出', 3001, 5, '', '', '', 1, 0, 'F', '0', '0', 'hit:project:export', '#', 103, 1, '2025-08-12 13:43:01', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3106, '项目申请', 3001, 6, '', '', '', 1, 0, 'F', '0', '0', 'hit:project:apply', '#', 103, 1, '2025-08-12 13:43:01', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3107, '项目收藏', 3001, 7, '', '', '', 1, 0, 'F', '0', '0', 'hit:project:collect', '#', 103, 1, '2025-08-12 13:43:01', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3108, '项目点赞', 3001, 8, '', '', '', 1, 0, 'F', '0', '0', 'hit:project:like', '#', 103, 1, '2025-08-12 13:43:01', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3109, '我的项目查询', 3002, 1, '', '', '', 1, 0, 'F', '0', '0', 'hit:project:my:query', '#', 103, 1, '2025-08-12 13:43:02', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3110, '申请管理', 3002, 2, '', '', '', 1, 0, 'F', '0', '0', 'hit:project:applications:manage', '#', 103, 1, '2025-08-12 13:43:02', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3111, '成员管理', 3002, 3, '', '', '', 1, 0, 'F', '0', '0', 'hit:project:members:manage', '#', 103, 1, '2025-08-12 13:43:02', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3112, '项目统计', 3002, 4, '', '', '', 1, 0, 'F', '0', '0', 'hit:project:statistics', '#', 103, 1, '2025-08-12 13:43:02', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4000, '项目管理后台', 1, 12, 'projectManagement', 'system/projectManagement/index', '', 1, 0, 'C', '0', '0', 'system:projectManagement:list', 'list', 103, 1, '2025-08-12 15:32:37', NULL, NULL, '项目管理后台管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4001, '项目管理查询', 4000, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:projectManagement:query', '#', 103, 1, '2025-08-12 15:32:37', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4002, '项目批量操作', 4000, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:projectManagement:batchEdit', '#', 103, 1, '2025-08-12 15:32:37', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4003, '项目批量删除', 4000, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:projectManagement:batchRemove', '#', 103, 1, '2025-08-12 15:32:37', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4004, '项目数据导出', 4000, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:projectManagement:export', '#', 103, 1, '2025-08-12 15:32:37', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4005, '成员管理查询', 4000, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:memberManagement:query', '#', 103, 1, '2025-08-12 15:32:37', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4006, '成员批量操作', 4000, 6, '#', '', '', 1, 0, 'F', '0', '0', 'system:memberManagement:batchEdit', '#', 103, 1, '2025-08-12 15:32:37', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4007, '成员批量移除', 4000, 7, '#', '', '', 1, 0, 'F', '0', '0', 'system:memberManagement:batchRemove', '#', 103, 1, '2025-08-12 15:32:37', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4008, '成员角色管理', 4000, 8, '#', '', '', 1, 0, 'F', '0', '0', 'system:memberManagement:roleEdit', '#', 103, 1, '2025-08-12 15:32:37', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4009, '成员表现管理', 4000, 9, '#', '', '', 1, 0, 'F', '0', '0', 'system:memberManagement:performance', '#', 103, 1, '2025-08-12 15:32:37', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4010, '申请管理查询', 4000, 10, '#', '', '', 1, 0, 'F', '0', '0', 'system:applicationManagement:query', '#', 103, 1, '2025-08-12 15:32:37', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4011, '申请批量审核', 4000, 11, '#', '', '', 1, 0, 'F', '0', '0', 'system:applicationManagement:batchReview', '#', 103, 1, '2025-08-12 15:32:37', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4012, '申请详情查看', 4000, 12, '#', '', '', 1, 0, 'F', '0', '0', 'system:applicationManagement:detail', '#', 103, 1, '2025-08-12 15:32:37', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4013, '申请状态修改', 4000, 13, '#', '', '', 1, 0, 'F', '0', '0', 'system:applicationManagement:statusEdit', '#', 103, 1, '2025-08-12 15:32:37', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4014, '数据统计查看', 4000, 14, '#', '', '', 1, 0, 'F', '0', '0', 'system:statistics:view', '#', 103, 1, '2025-08-12 15:32:38', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4015, '报告生成', 4000, 15, '#', '', '', 1, 0, 'F', '0', '0', 'system:statistics:report', '#', 103, 1, '2025-08-12 15:32:38', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4016, '系统配置查看', 4000, 16, '#', '', '', 1, 0, 'F', '0', '0', 'system:projectConfig:view', '#', 103, 1, '2025-08-12 15:32:38', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4017, '系统配置修改', 4000, 17, '#', '', '', 1, 0, 'F', '0', '0', 'system:projectConfig:edit', '#', 103, 1, '2025-08-12 15:32:38', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4018, '系统维护操作', 4000, 18, '#', '', '', 1, 0, 'F', '0', '0', 'system:projectConfig:maintenance', '#', 103, 1, '2025-08-12 15:32:38', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4019, '数据备份', 4000, 19, '#', '', '', 1, 0, 'F', '0', '0', 'system:backup:execute', '#', 103, 1, '2025-08-12 15:32:38', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4020, '缓存管理', 4000, 20, '#', '', '', 1, 0, 'F', '0', '0', 'system:cache:manage', '#', 103, 1, '2025-08-12 15:32:38', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (11616, '工作流', 0, 6, 'workflow', '', '', 1, 0, 'M', '0', '1', '', 'workflow', 103, 1, '2025-08-08 13:50:02', 1, '2025-08-11 16:41:46', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (11618, '我的任务', 0, 7, 'task', '', '', 1, 0, 'M', '0', '1', '', 'my-task', 103, 1, '2025-08-08 13:50:02', 1, '2025-08-11 16:41:51', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (11619, '我的待办', 11618, 2, 'taskWaiting', 'workflow/task/taskWaiting', '', 1, 1, 'C', '0', '0', '', 'waiting', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (11620, '流程定义', 11616, 3, 'processDefinition', 'workflow/processDefinition/index', '', 1, 1, 'C', '0', '0', '', 'process-definition', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (11621, '流程实例', 11630, 1, 'processInstance', 'workflow/processInstance/index', '', 1, 1, 'C', '0', '0', '', 'tree-table', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (11622, '流程分类', 11616, 1, 'category', 'workflow/category/index', '', 1, 0, 'C', '0', '0', 'workflow:category:list', 'category', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (11623, '流程分类查询', 11622, 1, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:category:query', '#', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (11624, '流程分类新增', 11622, 2, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:category:add', '#', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (11625, '流程分类修改', 11622, 3, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:category:edit', '#', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (11626, '流程分类删除', 11622, 4, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:category:remove', '#', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (11627, '流程分类导出', 11622, 5, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:category:export', '#', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (11629, '我发起的', 11618, 1, 'myDocument', 'workflow/task/myDocument', '', 1, 1, 'C', '0', '0', '', 'guide', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (11630, '流程监控', 11616, 4, 'monitor', '', '', 1, 0, 'M', '0', '0', '', 'monitor', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (11631, '待办任务', 11630, 2, 'allTaskWaiting', 'workflow/task/allTaskWaiting', '', 1, 1, 'C', '0', '0', '', 'waiting', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (11632, '我的已办', 11618, 3, 'taskFinish', 'workflow/task/taskFinish', '', 1, 1, 'C', '0', '0', '', 'finish', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (11633, '我的抄送', 11618, 4, 'taskCopyList', 'workflow/task/taskCopyList', '', 1, 1, 'C', '0', '0', '', 'my-copy', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (11638, '请假申请', 5, 1, 'leave', 'workflow/leave/index', '', 1, 0, 'C', '0', '0', 'workflow:leave:list', '#', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '请假申请菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (11639, '请假申请查询', 11638, 1, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:leave:query', '#', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (11640, '请假申请新增', 11638, 2, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:leave:add', '#', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (11641, '请假申请修改', 11638, 3, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:leave:edit', '#', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (11642, '请假申请删除', 11638, 4, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:leave:remove', '#', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (11643, '请假申请导出', 11638, 5, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:leave:export', '#', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (11700, '流程设计', 11616, 5, 'design/index', 'workflow/processDefinition/design', '', 1, 1, 'C', '1', '0', 'workflow:leave:edit', '#', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (11701, '请假申请', 11616, 6, 'leaveEdit/index', 'workflow/leave/leaveEdit', '', 1, 1, 'C', '1', '0', 'workflow:leave:edit', '#', 103, 1, '2025-08-08 13:50:02', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1954826543377698817, '业务功能', 0, 8, 'businessFunction', NULL, NULL, 1, 0, 'M', '0', '0', NULL, 'category', 103, 1, '2025-08-11 16:45:42', 1, '2025-08-11 16:45:42', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1954826706762616834, '用户扩展档案', 1954826543377698817, 1, 'userProfile', 'hitUserProfile/userProfile/index', NULL, 1, 0, 'C', '0', '0', 'hitUserProfile:userProfile:list', '#', 103, 1, '2025-08-11 16:57:32', 1, '2025-08-11 17:00:27', '用户扩展档案菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1954826706762616835, '用户扩展档案查询', 1954826706762616834, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'hitUserProfile:userProfile:query', '#', 103, 1, '2025-08-11 16:57:32', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1954826706762616836, '用户扩展档案新增', 1954826706762616834, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'hitUserProfile:userProfile:add', '#', 103, 1, '2025-08-11 16:57:32', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1954826706762616837, '用户扩展档案修改', 1954826706762616834, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'hitUserProfile:userProfile:edit', '#', 103, 1, '2025-08-11 16:57:32', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1954826706762616838, '用户扩展档案删除', 1954826706762616834, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'hitUserProfile:userProfile:remove', '#', 103, 1, '2025-08-11 16:57:32', NULL, NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1954826706762616839, '用户扩展档案导出', 1954826706762616834, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'hitUserProfile:userProfile:export', '#', 103, 1, '2025-08-11 16:57:32', NULL, NULL, '');
COMMIT;

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
BEGIN;
INSERT INTO `sys_notice` (`notice_id`, `tenant_id`, `notice_title`, `notice_type`, `notice_content`, `status`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '000000', '温馨提醒：2018-07-01 新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '管理员');
INSERT INTO `sys_notice` (`notice_id`, `tenant_id`, `notice_title`, `notice_type`, `notice_content`, `status`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '000000', '维护通知：2018-07-01 系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '管理员');
COMMIT;

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
BEGIN;
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1954824877366595585, '000000', '代码生成', 6, 'org.dromara.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '0:0:0:0:0:0:0:1', '内网IP', '{\"tables\":\"hit_user_profile\",\"dataName\":\"master\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-11 16:39:04', 189);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1954825467886850050, '000000', '代码生成', 2, 'org.dromara.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":1,\"updateTime\":\"2025-08-11 16:41:25\",\"params\":{\"treeCode\":null,\"treeName\":null,\"treeParentCode\":null,\"parentMenuId\":null},\"tableId\":\"1954824876720672770\",\"dataName\":\"master\",\"tableName\":\"hit_user_profile\",\"tableComment\":\"用户扩展档案表\",\"subTableName\":null,\"subTableFkName\":null,\"className\":\"HitUserProfile\",\"tplCategory\":\"crud\",\"packageName\":\"org.dromara.hit\",\"moduleName\":\"hitUserProfile\",\"businessName\":\"userProfile\",\"functionName\":\"用户扩展档案\",\"functionAuthor\":\"LKD\",\"genType\":\"0\",\"genPath\":\"/\",\"pkColumn\":null,\"columns\":[{\"createDept\":103,\"createBy\":1,\"createTime\":\"2025-08-11 16:39:04\",\"updateBy\":1,\"updateTime\":\"2025-08-11 16:41:25\",\"columnId\":\"1954824877119131650\",\"tableId\":\"1954824876720672770\",\"columnName\":\"profile_id\",\"columnComment\":\"用户档案ID\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"profileId\",\"isPk\":\"1\",\"isIncrement\":\"1\",\"isRequired\":\"0\",\"isInsert\":null,\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":null,\"queryType\":\"EQ\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":1,\"required\":false,\"list\":true,\"pk\":true,\"superColumn\":false,\"usableColumn\":false,\"edit\":true,\"insert\":false,\"increment\":true,\"query\":false,\"capJavaField\":\"ProfileId\"},{\"createDept\":103,\"createBy\":1,\"createTime\":\"2025-08-11 16:39:04\",\"updateBy\":1,\"updateTime\":\"2025-08-11 16:41:25\",\"columnId\":\"1954824877177851905\",\"tableId\":\"1954824876720672770\",\"columnName\":\"user_id\",\"columnComment\":\"关联用户id\",\"columnType\":\"bigint\",\"javaType\":\"Long\",\"javaField\":\"userId\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"0\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"queryType\":\"EQ\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":2,\"required\":false,\"list\":true,\"pk\":false,\"superColumn\":false,\"usableColumn\":false,\"edit\":true,\"insert\":true,\"increment\":false,\"query\":true,\"capJavaField\":\"UserId\"},{\"createDept\":103,\"createBy\":1,\"createTime\":\"2025-08-11 16:39:04\",\"updateBy\":1,\"updateTime\":\"2025-08-11 16:41:25\",\"columnId\":\"1954824877177851906\",\"tableId\":\"1954824876720672770\",\"columnName\":\"student_id\",\"columnComment\":\"学号\",\"columnType\":\"varchar(20)\",\"javaType\":\"String\",\"javaField\":\"studentId\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"queryType\":\"EQ\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":3,\"required\":true,\"list\":true,\"pk\":false,\"superColumn\":false,\"usableColumn\":false,\"edit\":true,\"insert\":true,\"increment\":false,\"query\":true,\"capJavaField\":\"StudentId\"},{\"createDept\":103,\"createBy\":1,\"createTime\":\"2025-08-11 16:39:04\",\"updateBy\":1,\"updateTime\":\"2025-08-11 16:41:25\",\"columnId\":\"1954824877177851907\",\"tableId\":\"1954824876720672770\",\"columnName\":\"real_name\",\"columnComment\":\"真实姓名\",\"columnType\":\"varchar(50)\",\"javaType\":\"String\",\"javaField\":\"realName\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"queryType\":\"LIKE\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":4,\"required\":true,\"list\":true,\"pk\":false,\"superColumn\":false,\"usableColumn\":false,\"edit\":true,\"insert\":true,\"increment\":false,\"query\":true,\"capJavaField\":\"RealName\"},{\"createDept\":103,\"createBy\":1,\"createTime\":\"2025-08-11 16:39:04\",\"updateBy\":1,\"updateTime\":\"2025-08-11 16:41:25\",\"columnId\":\"1954824877177851908\",\"tableId\":\"1954824876720672770\",\"columnName\":\"college\",\"columnComment\":\"所属学院\",\"columnType\":\"varchar(100)\",\"javaType\":\"String\",\"javaField\":\"college\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"queryType\":\"EQ\",\"htmlType\":\"select\",\"dictType\":\"hit_college\",\"sort\":5,\"required\":true,\"list\":true,\"pk\":false,\"superColumn\":false,\"usableColumn\":false,\"edit\":true,\"insert\":true,\"increment\":false,\"query\":true,\"capJavaField\":\"College\"},{\"createDept\":103,\"createBy\":1,\"createTime\":\"2025-08-11 16:39:04\",\"updateBy\":1,\"updateTime\":\"2025-08-11 16:41:25\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-11 16:41:25', 137);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1954825556013371394, '000000', '菜单管理', 2, 'org.dromara.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":103,\"createBy\":null,\"createTime\":\"2025-08-08 13:50:02\",\"updateBy\":null,\"updateTime\":null,\"menuId\":11616,\"parentId\":0,\"menuName\":\"工作流\",\"orderNum\":6,\"path\":\"workflow\",\"component\":\"\",\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"1\",\"perms\":\"\",\"icon\":\"workflow\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-11 16:41:46', 19);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1954825578465480706, '000000', '菜单管理', 2, 'org.dromara.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":103,\"createBy\":null,\"createTime\":\"2025-08-08 13:50:02\",\"updateBy\":null,\"updateTime\":null,\"menuId\":11618,\"parentId\":0,\"menuName\":\"我的任务\",\"orderNum\":7,\"path\":\"task\",\"component\":\"\",\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"1\",\"perms\":\"\",\"icon\":\"my-task\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-11 16:41:51', 22);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1954825605124476930, '000000', '菜单管理', 2, 'org.dromara.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":103,\"createBy\":null,\"createTime\":\"2025-08-08 13:49:43\",\"updateBy\":null,\"updateTime\":null,\"menuId\":5,\"parentId\":0,\"menuName\":\"测试菜单\",\"orderNum\":5,\"path\":\"demo\",\"component\":null,\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"1\",\"perms\":\"\",\"icon\":\"star\",\"remark\":\"测试菜单\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-11 16:41:58', 21);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1954825641791082497, '000000', '菜单管理', 3, 'org.dromara.system.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/4', '0:0:0:0:0:0:0:1', '内网IP', '4', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-11 16:42:07', 29);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1954825670719197185, '000000', '菜单管理', 2, 'org.dromara.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":103,\"createBy\":null,\"createTime\":\"2025-08-08 13:49:43\",\"updateBy\":null,\"updateTime\":null,\"menuId\":2,\"parentId\":0,\"menuName\":\"系统监控\",\"orderNum\":3,\"path\":\"monitor\",\"component\":null,\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"1\",\"perms\":\"\",\"icon\":\"monitor\",\"remark\":\"系统监控目录\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-11 16:42:13', 8);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1954825694710616066, '000000', '菜单管理', 2, 'org.dromara.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":103,\"createBy\":null,\"createTime\":\"2025-08-08 13:49:43\",\"updateBy\":null,\"updateTime\":null,\"menuId\":6,\"parentId\":0,\"menuName\":\"租户管理\",\"orderNum\":2,\"path\":\"tenant\",\"component\":null,\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"1\",\"perms\":\"\",\"icon\":\"chart\",\"remark\":\"租户管理目录\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-11 16:42:19', 25);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1954825995274440706, '000000', '个人信息', 2, 'org.dromara.system.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', '研发部门', '/system/user/profile', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":\"2025-08-08 13:49:43\",\"updateBy\":null,\"updateTime\":null,\"nickName\":\"迪迦\",\"email\":\"770276349@qq.com\",\"phonenumber\":\"18878688656\",\"sex\":\"0\"}', '{\"code\":500,\"msg\":\"修改用户\'admin\'失败，手机号码已存在\",\"data\":null}', 0, '', '2025-08-11 16:43:31', 6);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1954826034537320450, '000000', '个人信息', 2, 'org.dromara.system.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', '研发部门', '/system/user/profile', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":\"2025-08-08 13:49:43\",\"updateBy\":null,\"updateTime\":null,\"nickName\":\"迪迦\",\"email\":\"770276349@qq.com\",\"phonenumber\":\"15888888888\",\"sex\":\"0\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-11 16:43:40', 43);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1954826543444807682, '000000', '菜单管理', 1, 'org.dromara.system.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":null,\"parentId\":0,\"menuName\":\"业务功能\",\"orderNum\":8,\"path\":\"businessFunction\",\"component\":null,\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"0\",\"icon\":\"category\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-11 16:45:42', 26);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1954826708444532737, '000000', '代码生成', 8, 'org.dromara.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '0:0:0:0:0:0:0:1', '内网IP', '{\"tableIdStr\":\"1954824876720672770\"}', '', 0, '', '2025-08-11 16:46:21', 401);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1954830256733548546, '000000', '菜单管理', 2, 'org.dromara.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":103,\"createBy\":null,\"createTime\":\"2025-08-11 16:57:32\",\"updateBy\":null,\"updateTime\":null,\"menuId\":\"1954826706762616834\",\"parentId\":\"1954826543377698817\",\"menuName\":\"用户扩展档案\",\"orderNum\":1,\"path\":\"userProfile\",\"component\":\"hitUserProfile/userProfile/index\",\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"hitUserProfile:userProfile:list\",\"icon\":\"#\",\"remark\":\"用户扩展档案菜单\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-11 17:00:27', 34);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955111815312904194, '000000', '对象存储配置', 2, 'org.dromara.system.controller.system.SysOssConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/resource/oss/config', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"ossConfigId\":1,\"configKey\":\"minio\",\"accessKey\":\"hitroot\",\"secretKey\":\"hit@123456\",\"bucketName\":\"hit-bucket\",\"prefix\":\"\",\"endpoint\":\"123.56.113.24:9100\",\"domain\":\"\",\"isHttps\":\"N\",\"status\":\"0\",\"region\":\"\",\"ext1\":\"\",\"remark\":null,\"accessPolicy\":\"1\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-12 11:39:16', 79);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955112360098467841, '000000', 'OSS对象存储', 1, 'org.dromara.system.controller.system.SysOssController.upload()', 'POST', 1, 'admin', '研发部门', '/resource/oss/upload', '0:0:0:0:0:0:0:1', '内网IP', '', '{\"code\":200,\"msg\":\"操作成功\",\"data\":{\"url\":\"http://123.56.113.24:9100/hit-bucket/2025/08/12/f873911d60cd4cb2beb26f823b0d12aa.png\",\"fileName\":\"民间借贷纠纷起诉状.png\",\"ossId\":\"1955112359939084289\"}}', 0, '', '2025-08-12 11:41:26', 795);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955112374883389441, '000000', 'OSS对象存储', 3, 'org.dromara.system.controller.system.SysOssController.remove()', 'DELETE', 1, 'admin', '研发部门', '/resource/oss/1955112359939084289', '0:0:0:0:0:0:0:1', '内网IP', '[\"1955112359939084289\"]', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-12 11:41:29', 49);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955163766364901378, '000000', 'OSS对象存储', 1, 'org.dromara.system.controller.system.SysOssController.upload()', 'POST', 1, 'admin', '研发部门', '/resource/oss/upload', '0:0:0:0:0:0:0:1', '内网IP', '', '{\"code\":200,\"msg\":\"操作成功\",\"data\":{\"url\":\"http://123.56.113.24:9100/hit-bucket/2025/08/12/b0ca2434af794a29b804518cdfe59d8d.png\",\"fileName\":\"鼠鼠.png\",\"ossId\":\"1955163766247460865\"}}', 0, '', '2025-08-12 15:05:42', 738);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955163946648670209, '000000', '用户头像', 2, 'org.dromara.system.controller.system.SysProfileController.avatar()', 'POST', 1, 'admin', '研发部门', '/system/user/profile/avatar', '0:0:0:0:0:0:0:1', '内网IP', '', '{\"code\":200,\"msg\":\"操作成功\",\"data\":{\"imgUrl\":\"http://123.56.113.24:9100/hit-bucket/2025/08/12/d5d539eb357f4c428e716752b6dff047.png\"}}', 0, '', '2025-08-12 15:06:25', 503);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955168819763023874, '000000', '用户头像', 2, 'org.dromara.system.controller.system.SysProfileController.avatar()', 'POST', 1, 'admin', '研发部门', '/system/user/profile/avatar', '0:0:0:0:0:0:0:1', '内网IP', '', '{\"code\":200,\"msg\":\"操作成功\",\"data\":{\"imgUrl\":\"http://123.56.113.24:9100/hit-bucket/2025/08/12/3989b432c73d4b19b83fec43c432f901.png\"}}', 0, '', '2025-08-12 15:25:47', 826);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955182309194199041, '000000', '菜单管理', 2, 'org.dromara.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":103,\"createBy\":null,\"createTime\":\"2025-08-11 14:26:57\",\"updateBy\":null,\"updateTime\":null,\"menuId\":2005,\"parentId\":2001,\"menuName\":\"技能标签\",\"orderNum\":4,\"path\":\"skillTag\",\"component\":\"hit/skillTag/index\",\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"hit:skillTag:list\",\"icon\":\"finish\",\"remark\":\"技能标签管理菜单\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-12 16:19:23', 75);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955182413661728769, '000000', '菜单管理', 2, 'org.dromara.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":103,\"createBy\":null,\"createTime\":\"2025-08-11 14:26:57\",\"updateBy\":null,\"updateTime\":null,\"menuId\":2006,\"parentId\":2001,\"menuName\":\"名片展示\",\"orderNum\":5,\"path\":\"profileCard\",\"component\":\"hit/profileCard/index\",\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"hit:profileCard:view\",\"icon\":\"people\",\"remark\":\"名片展示菜单\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-12 16:19:48', 20);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955189000304390145, '000000', 'OSS对象存储', 1, 'org.dromara.system.controller.system.SysOssController.upload()', 'POST', 1, 'admin', '研发部门', '/resource/oss/upload', '0:0:0:0:0:0:0:1', '内网IP', '', '', 1, '上传文件失败，请检查配置信息:[The service request was not made within 30 seconds of doBlockingWrite being invoked. Make sure to invoke the service request BEFORE invoking doBlockingWrite if your caller is single-threaded.]', '2025-08-12 16:45:58', 30014);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955189130084544514, '000000', 'OSS对象存储', 1, 'org.dromara.system.controller.system.SysOssController.upload()', 'POST', 1, 'admin', '研发部门', '/resource/oss/upload', '0:0:0:0:0:0:0:1', '内网IP', '', '', 1, '上传文件失败，请检查配置信息:[The service request was not made within 30 seconds of doBlockingWrite being invoked. Make sure to invoke the service request BEFORE invoking doBlockingWrite if your caller is single-threaded.]', '2025-08-12 16:46:29', 30011);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955189283432493058, '000000', 'OSS对象存储', 1, 'org.dromara.system.controller.system.SysOssController.upload()', 'POST', 1, 'admin', '研发部门', '/resource/oss/upload', '0:0:0:0:0:0:0:1', '内网IP', '', '', 1, '上传文件失败，请检查配置信息:[The service request was not made within 30 seconds of doBlockingWrite being invoked. Make sure to invoke the service request BEFORE invoking doBlockingWrite if your caller is single-threaded.]', '2025-08-12 16:47:05', 30010);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955189594486272001, '000000', 'OSS对象存储', 3, 'org.dromara.system.controller.system.SysOssController.remove()', 'DELETE', 1, 'admin', '研发部门', '/resource/oss/1955163946438955010,1955163766247460865', '0:0:0:0:0:0:0:1', '内网IP', '[\"1955163946438955010\",\"1955163766247460865\"]', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-12 16:48:20', 291);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955189742381625346, '000000', 'OSS对象存储', 1, 'org.dromara.system.controller.system.SysOssController.upload()', 'POST', 1, 'admin', '研发部门', '/resource/oss/upload', '0:0:0:0:0:0:0:1', '内网IP', '', '', 1, '上传文件失败，请检查配置信息:[The service request was not made within 30 seconds of doBlockingWrite being invoked. Make sure to invoke the service request BEFORE invoking doBlockingWrite if your caller is single-threaded.]', '2025-08-12 16:48:55', 30010);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955190423352045569, '000000', '对象存储配置', 2, 'org.dromara.system.controller.system.SysOssConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/resource/oss/config', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"ossConfigId\":1,\"configKey\":\"minio\",\"accessKey\":\"hitroot\",\"secretKey\":\"hit@123456\",\"bucketName\":\"hit-bucket\",\"prefix\":\"\",\"endpoint\":\"123.56.113.24:9100\",\"domain\":\"\",\"isHttps\":\"N\",\"status\":\"0\",\"region\":\"\",\"ext1\":\"\",\"remark\":\"\",\"accessPolicy\":\"1\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-12 16:51:37', 338);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955190450795376641, '000000', '对象存储状态修改', 2, 'org.dromara.system.controller.system.SysOssConfigController.changeStatus()', 'PUT', 1, 'admin', '研发部门', '/resource/oss/config/changeStatus', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"ossConfigId\":1,\"configKey\":\"minio\",\"accessKey\":null,\"secretKey\":null,\"bucketName\":null,\"prefix\":null,\"endpoint\":null,\"domain\":null,\"isHttps\":null,\"status\":\"1\",\"region\":null,\"ext1\":null,\"remark\":null,\"accessPolicy\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-12 16:51:44', 526);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955190460790403073, '000000', '对象存储状态修改', 2, 'org.dromara.system.controller.system.SysOssConfigController.changeStatus()', 'PUT', 1, 'admin', '研发部门', '/resource/oss/config/changeStatus', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"ossConfigId\":1,\"configKey\":\"minio\",\"accessKey\":null,\"secretKey\":null,\"bucketName\":null,\"prefix\":null,\"endpoint\":null,\"domain\":null,\"isHttps\":null,\"status\":\"0\",\"region\":null,\"ext1\":null,\"remark\":null,\"accessPolicy\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-12 16:51:46', 458);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955190534308163586, '000000', 'OSS对象存储', 1, 'org.dromara.system.controller.system.SysOssController.upload()', 'POST', 1, 'admin', '研发部门', '/resource/oss/upload', '0:0:0:0:0:0:0:1', '内网IP', '', '{\"code\":200,\"msg\":\"操作成功\",\"data\":{\"url\":\"http://123.56.113.24:9100/hit-bucket/2025/08/12/5dd92c1960434c1bbaf9e34e70267c6f.png\",\"fileName\":\"鼠鼠.png\",\"ossId\":\"1955190533523828737\"}}', 0, '', '2025-08-12 16:52:04', 976);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955190632631037954, '000000', 'OSS对象存储', 1, 'org.dromara.system.controller.system.SysOssController.upload()', 'POST', 1, 'admin', '研发部门', '/resource/oss/upload', '0:0:0:0:0:0:0:1', '内网IP', '', '{\"code\":200,\"msg\":\"操作成功\",\"data\":{\"url\":\"http://123.56.113.24:9100/hit-bucket/2025/08/12/2c67facc35144614ae63f589c7c2857f.png\",\"fileName\":\"鼠鼠.png\",\"ossId\":\"1955190631871868930\"}}', 0, '', '2025-08-12 16:52:27', 906);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955190894548496386, '000000', '用户作品集', 2, 'org.dromara.hit.controller.HitUserPortfolioController.edit()', 'PUT', 1, 'admin', '研发部门', '/hit/userPortfolio', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"portfolioId\":4,\"userId\":null,\"portfolioTitle\":\"HIT项目组队通系统\",\"portfolioDescription\":\"基于Spring Boot和Vue.js开发的项目组队管理系统，支持项目发布、团队组建、任务管理等功能\",\"workType\":\"project\",\"coverImage\":\"http://123.56.113.24:9100/hit-bucket/2025/08/12/2c67facc35144614ae63f589c7c2857f.png\",\"demoUrl\":null,\"repositoryUrl\":\"https://github.com/zhangsan/hit-project\",\"downloadUrl\":null,\"techStack\":\"[\\\"Spring Boot\\\", \\\"Vue.js\\\", \\\"MySQL\\\", \\\"Redis\\\"]\",\"myRole\":null,\"teamSize\":null,\"startDate\":null,\"endDate\":null,\"viewCount\":null,\"likeCount\":null,\"isFeatured\":\"0\",\"isPublic\":\"0\",\"sortOrder\":null,\"status\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-12 16:53:30', 209);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955192982930206721, '000000', 'OSS对象存储', 1, 'org.dromara.system.controller.system.SysOssController.upload()', 'POST', 1, 'admin', '研发部门', '/resource/oss/upload', '0:0:0:0:0:0:0:1', '内网IP', '', '{\"code\":200,\"msg\":\"操作成功\",\"data\":{\"url\":\"http://123.56.113.24:9100/hit-bucket/2025/08/12/163fe40dbb604c289dd5753466e798fa.png\",\"fileName\":\"萨摩耶.png\",\"ossId\":\"1955192982032625665\"}}', 0, '', '2025-08-12 17:01:48', 1287);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955192990287015938, '000000', '用户作品集', 2, 'org.dromara.hit.controller.HitUserPortfolioController.edit()', 'PUT', 1, 'admin', '研发部门', '/hit/userPortfolio', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"portfolioId\":5,\"userId\":null,\"portfolioTitle\":\"个人博客系统\",\"portfolioDescription\":\"使用Vue3和Spring Boot开发的个人博客系统，支持文章发布、评论、标签分类等功能\",\"workType\":\"project\",\"coverImage\":\"http://123.56.113.24:9100/hit-bucket/2025/08/12/163fe40dbb604c289dd5753466e798fa.png\",\"demoUrl\":null,\"repositoryUrl\":\"https://github.com/zhangsan/personal-blog\",\"downloadUrl\":null,\"techStack\":\"[\\\"Vue3\\\", \\\"Spring Boot\\\", \\\"MyBatis Plus\\\", \\\"Element Plus\\\"]\",\"myRole\":null,\"teamSize\":null,\"startDate\":null,\"endDate\":null,\"viewCount\":null,\"likeCount\":null,\"isFeatured\":\"0\",\"isPublic\":\"1\",\"sortOrder\":null,\"status\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-12 17:01:49', 177);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955193001993318401, '000000', '用户作品集', 3, 'org.dromara.hit.controller.HitUserPortfolioController.remove()', 'DELETE', 1, 'admin', '研发部门', '/hit/userPortfolio/6', '0:0:0:0:0:0:0:1', '内网IP', '[6]', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-12 17:01:52', 205);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955266212131028994, '000000', '菜单管理', 2, 'org.dromara.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":103,\"createBy\":null,\"createTime\":\"2025-08-12 13:43:01\",\"updateBy\":null,\"updateTime\":null,\"menuId\":3000,\"parentId\":0,\"menuName\":\"HIT项目\",\"orderNum\":0,\"path\":\"hit\",\"component\":null,\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"\",\"icon\":\"category\",\"remark\":\"HIT项目管理模块\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-12 21:52:47', 277);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955272909947977729, '000000', 'OSS对象存储', 1, 'org.dromara.system.controller.system.SysOssController.upload()', 'POST', 1, 'admin', '研发部门', '/resource/oss/upload', '0:0:0:0:0:0:0:1', '内网IP', '', '{\"code\":200,\"msg\":\"操作成功\",\"data\":{\"url\":\"http://123.56.113.24:9100/hit-bucket/2025/08/12/56c94addb07349f8ab4a75517590a22e.png\",\"fileName\":\"萨摩耶.png\",\"ossId\":\"1955272909142671361\"}}', 0, '', '2025-08-12 22:19:24', 1071);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955272950431399937, '000000', '项目信息', 2, 'org.dromara.hit.project.controller.HitProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/hit/project', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"projectId\":1,\"projectName\":\"智慧校园移动应用开发\",\"projectDescription\":\"基于Vue3和Spring Boot开发的智慧校园移动应用，包含学生信息管理、课程安排、成绩查询等功能。\",\"projectBackground\":\"随着移动互联网的发展，传统的校园管理系统已经无法满足师生的移动办公需求。需要开发一套完整的移动端应用系统。\",\"projectGoals\":\"开发一套功能完善的智慧校园移动应用，提升师生的校园生活体验。\",\"expectedOutcome\":\"完成移动端APP开发，包含前端界面、后端API、数据库设计等完整功能。\",\"coverImage\":\"http://123.56.113.24:9100/hit-bucket/2025/08/12/56c94addb07349f8ab4a75517590a22e.png\",\"projectType\":\"academic\",\"projectCategory\":null,\"difficultyLevel\":3,\"durationType\":null,\"startDate\":\"2025-02-01\",\"endDate\":\"2025-07-31\",\"teamSizeMin\":null,\"teamSizeMax\":6,\"currentMembers\":null,\"status\":\"recruiting\",\"recruitmentStatus\":\"open\",\"visibility\":\"public\",\"approvalMode\":\"manual\",\"isFeatured\":\"1\",\"isUrgent\":\"0\",\"isCredit\":\"1\",\"creatorId\":null,\"mentorId\":null,\"deptId\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-12 22:19:33', 193);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955272984191352834, '000000', 'OSS对象存储', 1, 'org.dromara.system.controller.system.SysOssController.upload()', 'POST', 1, 'admin', '研发部门', '/resource/oss/upload', '0:0:0:0:0:0:0:1', '内网IP', '', '{\"code\":200,\"msg\":\"操作成功\",\"data\":{\"url\":\"http://123.56.113.24:9100/hit-bucket/2025/08/12/7bb076b32c524e10b5356a663dcf360c.png\",\"fileName\":\"鼠鼠.png\",\"ossId\":\"1955272983474126850\"}}', 0, '', '2025-08-12 22:19:41', 640);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955272992437354497, '000000', '项目信息', 2, 'org.dromara.hit.project.controller.HitProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/hit/project', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"projectId\":2,\"projectName\":\"人工智能图像识别系统\",\"projectDescription\":\"基于深度学习的图像识别系统，能够识别校园内的各种物体和场景，为智慧校园建设提供技术支持。\",\"projectBackground\":\"人工智能技术在图像识别领域发展迅速，将AI技术应用到校园管理中具有重要意义。\",\"projectGoals\":\"研发一套高精度的图像识别系统，提升校园智能化水平。\",\"expectedOutcome\":\"完成AI模型训练、系统集成、性能优化等工作，达到实用化标准。\",\"coverImage\":\"http://123.56.113.24:9100/hit-bucket/2025/08/12/7bb076b32c524e10b5356a663dcf360c.png\",\"projectType\":\"competition\",\"projectCategory\":null,\"difficultyLevel\":4,\"durationType\":null,\"startDate\":\"2025-01-15\",\"endDate\":\"2025-12-31\",\"teamSizeMin\":null,\"teamSizeMax\":8,\"currentMembers\":null,\"status\":\"recruiting\",\"recruitmentStatus\":\"open\",\"visibility\":\"public\",\"approvalMode\":\"manual\",\"isFeatured\":\"1\",\"isUrgent\":\"1\",\"isCredit\":\"0\",\"creatorId\":null,\"mentorId\":null,\"deptId\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-12 22:19:43', 177);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955273147563687937, '000000', '项目信息', 3, 'org.dromara.hit.project.controller.HitProjectController.remove()', 'DELETE', 1, 'admin', '研发部门', '/hit/project/5,3', '0:0:0:0:0:0:0:1', '内网IP', '[5,3]', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-12 22:20:20', 189);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955273354510647298, '000000', 'OSS对象存储', 1, 'org.dromara.system.controller.system.SysOssController.upload()', 'POST', 1, 'admin', '研发部门', '/resource/oss/upload', '0:0:0:0:0:0:0:1', '内网IP', '', '{\"code\":200,\"msg\":\"操作成功\",\"data\":{\"url\":\"http://123.56.113.24:9100/hit-bucket/2025/08/12/6da83a31d5084074a3df23b0b1b0a365.png\",\"fileName\":\"机器人.png\",\"ossId\":\"1955273353755672578\"}}', 0, '', '2025-08-12 22:21:10', 613);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955273364644085761, '000000', '项目信息', 2, 'org.dromara.hit.project.controller.HitProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/hit/project', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"projectId\":4,\"projectName\":\"机器人控制系统设计\",\"projectDescription\":\"设计并实现一个多功能服务机器人的控制系统，包含导航、避障、语音交互等功能。\",\"projectBackground\":\"服务机器人在教育、医疗、家庭等领域应用前景广阔，控制系统是核心技术。\",\"projectGoals\":\"开发一套稳定可靠的机器人控制系统。\",\"expectedOutcome\":\"完成控制算法设计、硬件集成、系统测试等工作。\",\"coverImage\":\"http://123.56.113.24:9100/hit-bucket/2025/08/12/6da83a31d5084074a3df23b0b1b0a365.png\",\"projectType\":\"graduation\",\"projectCategory\":null,\"difficultyLevel\":3,\"durationType\":null,\"startDate\":\"2025-02-15\",\"endDate\":\"2025-06-15\",\"teamSizeMin\":null,\"teamSizeMax\":5,\"currentMembers\":null,\"status\":\"recruiting\",\"recruitmentStatus\":\"open\",\"visibility\":\"public\",\"approvalMode\":\"manual\",\"isFeatured\":\"0\",\"isUrgent\":\"0\",\"isCredit\":\"0\",\"creatorId\":null,\"mentorId\":null,\"deptId\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-12 22:21:12', 170);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955276098558541826, '000000', '项目点赞', 2, 'org.dromara.hit.project.controller.HitProjectController.like()', 'POST', 1, 'admin', '研发部门', '/hit/project/1/like', '0:0:0:0:0:0:0:1', '内网IP', '1', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-12 22:32:04', 208);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955607161415688194, '000000', '用户管理', 1, 'org.dromara.system.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"userId\":\"1955607159649886210\",\"deptId\":100,\"userName\":\"zhangsan\",\"nickName\":\"张三\",\"userType\":null,\"email\":null,\"phonenumber\":null,\"sex\":null,\"status\":\"0\",\"remark\":\"\",\"roleIds\":[3],\"postIds\":[],\"roleId\":null,\"userIds\":null,\"excludeUserIds\":null,\"superAdmin\":false}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-13 20:27:35', 749);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955607222220513281, '000000', '用户管理', 1, 'org.dromara.system.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"userId\":\"1955607220618289154\",\"deptId\":100,\"userName\":\"lisi\",\"nickName\":\"李四\",\"userType\":null,\"email\":null,\"phonenumber\":null,\"sex\":null,\"status\":\"0\",\"remark\":\"\",\"roleIds\":[3],\"postIds\":[],\"roleId\":null,\"userIds\":null,\"excludeUserIds\":null,\"superAdmin\":false}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-13 20:27:50', 648);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955607393578803201, '000000', '角色管理', 2, 'org.dromara.system.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":\"2025-08-08 13:49:43\",\"updateBy\":null,\"updateTime\":null,\"roleId\":3,\"roleName\":\"本部门及以下\",\"roleKey\":\"test1\",\"roleSort\":3,\"dataScope\":\"4\",\"menuCheckStrictly\":true,\"deptCheckStrictly\":true,\"status\":\"0\",\"remark\":\"\",\"menuIds\":[3000,3001,3101,3102,3103,3104,3105,3106,3107,3108,3007,3009,3002,3109,3110,3111,3112,3008,3010,3011,2001,2002,2011,2012,2013,2014,2015,2003,2021,2022,2023,2024,2025,2004,2031,2032,2033,2034,2035,2005,2041,2042,2043,2044,2045,2006,2051,2052,2053],\"deptIds\":[],\"superAdmin\":false}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-13 20:28:31', 830);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955904999580295169, '000000', '菜单管理', 2, 'org.dromara.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":103,\"createBy\":null,\"createTime\":\"2025-08-12 13:43:01\",\"updateBy\":null,\"updateTime\":null,\"menuId\":3002,\"parentId\":3000,\"menuName\":\"我的项目\",\"orderNum\":2,\"path\":\"project/my\",\"component\":\"hit/project/my\",\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"hit:project:my\",\"icon\":\"build\",\"remark\":\"我的项目管理菜单\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-14 16:11:06', 245);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955907288546205698, '000000', '角色管理', 2, 'org.dromara.system.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":\"2025-08-08 13:49:43\",\"updateBy\":null,\"updateTime\":null,\"roleId\":3,\"roleName\":\"本部门及以下\",\"roleKey\":\"test1\",\"roleSort\":3,\"dataScope\":\"4\",\"menuCheckStrictly\":true,\"deptCheckStrictly\":true,\"status\":\"0\",\"remark\":\"\",\"menuIds\":[3000,3001,3101,3102,3103,3104,3105,3106,3107,3108,3007,3009,3002,3109,3110,3111,3112,3008,3010,3011,3012,2001,2002,2011,2012,2013,2014,2015,2003,2021,2022,2023,2024,2025,2004,2031,2032,2033,2034,2035,2005,2041,2042,2043,2044,2045,2006,2051,2052,2053],\"deptIds\":[],\"superAdmin\":false}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-14 16:20:11', 915);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955931659306323969, '000000', '项目信息', 3, 'org.dromara.hit.project.controller.HitProjectController.remove()', 'DELETE', 1, 'admin', '研发部门', '/hit/project/3', '0:0:0:0:0:0:0:1', '内网IP', '[3]', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-14 17:57:02', 194);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955931677794816001, '000000', '项目信息', 3, 'org.dromara.hit.project.controller.HitProjectController.remove()', 'DELETE', 1, 'admin', '研发部门', '/hit/project/5', '0:0:0:0:0:0:0:1', '内网IP', '[5]', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-14 17:57:06', 178);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955969199245676546, '000000', 'OSS对象存储', 1, 'org.dromara.system.controller.system.SysOssController.upload()', 'POST', 1, 'admin', '研发部门', '/resource/oss/upload', '0:0:0:0:0:0:0:1', '内网IP', '', '{\"code\":200,\"msg\":\"操作成功\",\"data\":{\"url\":\"http://123.56.113.24:9100/hit-bucket/2025/08/14/02d4113189d5467aa230aa53b94832fa.png\",\"fileName\":\"魔丸.png\",\"ossId\":\"1955969198419398657\"}}', 0, '', '2025-08-14 20:26:12', 1013);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955970586012602370, '000000', 'OSS对象存储', 1, 'org.dromara.system.controller.system.SysOssController.upload()', 'POST', 1, 'admin', '研发部门', '/resource/oss/upload', '0:0:0:0:0:0:0:1', '内网IP', '', '{\"code\":200,\"msg\":\"操作成功\",\"data\":{\"url\":\"http://123.56.113.24:9100/hit-bucket/2025/08/14/19b403cbc39343d6aaf40efdf9adda76.png\",\"fileName\":\"魔丸.png\",\"ossId\":\"1955970585253433346\"}}', 0, '', '2025-08-14 20:31:43', 674);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955970655440916481, '000000', '项目信息', 1, 'org.dromara.hit.project.controller.HitProjectController.add()', 'POST', 1, 'admin', '研发部门', '/hit/project', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"projectId\":\"1955970654602055682\",\"projectName\":\"吹爆魔丸\",\"projectDescription\":\"吹爆我的魔丸！！！！！\",\"projectBackground\":\"\",\"projectGoals\":\"\",\"expectedOutcome\":\"\",\"coverImage\":\"http://123.56.113.24:9100/hit-bucket/2025/08/14/19b403cbc39343d6aaf40efdf9adda76.png\",\"projectType\":\"academic\",\"projectCategory\":null,\"difficultyLevel\":1,\"durationType\":null,\"startDate\":\"2025-08-14\",\"endDate\":\"2025-08-28\",\"teamSizeMin\":null,\"teamSizeMax\":5,\"currentMembers\":null,\"status\":null,\"recruitmentStatus\":\"open\",\"visibility\":\"public\",\"approvalMode\":\"auto\",\"isFeatured\":\"0\",\"isUrgent\":\"0\",\"isCredit\":\"0\",\"creatorId\":null,\"mentorId\":null,\"deptId\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-14 20:31:59', 206);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955983723814252545, '000000', '项目信息', 3, 'org.dromara.hit.project.controller.HitProjectController.remove()', 'DELETE', 1, 'admin', '研发部门', '/hit/project/1955970654602055682', '0:0:0:0:0:0:0:1', '内网IP', '[\"1955970654602055682\"]', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-14 21:23:55', 198);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955983804437164034, '000000', 'OSS对象存储', 1, 'org.dromara.system.controller.system.SysOssController.upload()', 'POST', 1, 'admin', '研发部门', '/resource/oss/upload', '0:0:0:0:0:0:0:1', '内网IP', '', '{\"code\":200,\"msg\":\"操作成功\",\"data\":{\"url\":\"http://123.56.113.24:9100/hit-bucket/2025/08/14/b8960fa9ca404aa6ac77d1940ca5c00b.png\",\"fileName\":\"魔丸.png\",\"ossId\":\"1955983803644440577\"}}', 0, '', '2025-08-14 21:24:14', 839);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955984164027428866, '000000', '项目信息', 1, 'org.dromara.hit.project.controller.HitProjectController.add()', 'POST', 1, 'admin', '研发部门', '/hit/project', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"projectId\":\"1955984161988997122\",\"projectName\":\"吹爆魔丸\",\"projectDescription\":\"吹爆我的魔丸！！！！！\",\"projectBackground\":\"\",\"projectGoals\":\"\",\"expectedOutcome\":\"\",\"coverImage\":\"http://123.56.113.24:9100/hit-bucket/2025/08/14/b8960fa9ca404aa6ac77d1940ca5c00b.png\",\"projectType\":\"competition\",\"projectCategory\":null,\"difficultyLevel\":2,\"durationType\":null,\"startDate\":\"2025-08-14\",\"endDate\":\"2025-08-29\",\"teamSizeMin\":null,\"teamSizeMax\":5,\"currentMembers\":null,\"status\":null,\"recruitmentStatus\":\"open\",\"visibility\":\"public\",\"approvalMode\":\"auto\",\"isFeatured\":\"0\",\"isUrgent\":\"0\",\"isCredit\":\"0\",\"creatorId\":null,\"mentorId\":null,\"deptId\":null}', '{\"code\":200,\"msg\":\"项目创建成功\",\"data\":\"1955984161988997122\"}', 0, '', '2025-08-14 21:25:40', 616);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955984165210222593, '000000', '项目角色', 1, 'org.dromara.hit.project.controller.HitProjectRoleController.add()', 'POST', 1, 'admin', '研发部门', '/hit/project/role', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"roleId\":\"1955984164694323201\",\"projectId\":\"1955984161988997122\",\"roleName\":\"前端工程师\",\"roleDescription\":\"有前端开发经验\",\"requiredSkills\":\"Vue\",\"responsibilities\":null,\"requiredCount\":3,\"currentCount\":null,\"experienceRequired\":null,\"timeCommitment\":null,\"isLeader\":\"0\",\"priority\":null,\"status\":\"0\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-14 21:25:40', 253);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955984165419937794, '000000', '项目角色', 1, 'org.dromara.hit.project.controller.HitProjectRoleController.add()', 'POST', 1, 'admin', '研发部门', '/hit/project/role', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"roleId\":\"1955984164908232705\",\"projectId\":\"1955984161988997122\",\"roleName\":\"后端开发工程师\",\"roleDescription\":\"后端开发经验\",\"requiredSkills\":\"JAVA\",\"responsibilities\":null,\"requiredCount\":1,\"currentCount\":null,\"experienceRequired\":null,\"timeCommitment\":null,\"isLeader\":\"0\",\"priority\":null,\"status\":\"0\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-14 21:25:40', 302);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955993361284657154, '000000', '添加项目成员', 1, 'org.dromara.hit.project.controller.HitProjectMemberController.addProjectMember()', 'POST', 1, 'admin', '研发部门', '/hit/project/member/add-member', '0:0:0:0:0:0:0:1', '内网IP', '{\"projectId\":\"1955984161988997000\",\"userId\":\"1955607159649886210\",\"memberRole\":\"普通成员\"}', '', 1, '项目不存在', '2025-08-14 22:02:13', 287);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955993420743110657, '000000', '添加项目成员', 1, 'org.dromara.hit.project.controller.HitProjectMemberController.addProjectMember()', 'POST', 1, 'admin', '研发部门', '/hit/project/member/add-member', '0:0:0:0:0:0:0:1', '内网IP', '{\"projectId\":\"1955984161988997000\",\"userId\":\"1955607159649886210\",\"memberRole\":\"普通成员\"}', '', 1, '项目不存在', '2025-08-14 22:02:27', 274);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955996832360624129, '000000', '添加项目成员', 1, 'org.dromara.hit.project.controller.HitProjectMemberController.addProjectMember()', 'POST', 1, 'admin', '研发部门', '/hit/project/member/add-member', '0:0:0:0:0:0:0:1', '内网IP', '{\"projectId\":\"1955984161988997000\",\"userId\":\"1955607159649886200\",\"memberRole\":\"普通成员\"}', '', 1, '项目不存在', '2025-08-14 22:16:00', 273);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955996896223096834, '000000', '添加项目成员', 1, 'org.dromara.hit.project.controller.HitProjectMemberController.addProjectMember()', 'POST', 1, 'admin', '研发部门', '/hit/project/member/add-member', '0:0:0:0:0:0:0:1', '内网IP', '{\"projectId\":\"1955984161988997000\",\"userId\":\"1955607159649886200\",\"memberRole\":\"普通成员\"}', '', 1, '项目不存在', '2025-08-14 22:16:15', 265);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955998960219123714, '000000', '添加项目成员', 1, 'org.dromara.hit.project.controller.HitProjectMemberController.addProjectMember()', 'POST', 1, 'admin', '研发部门', '/hit/project/member/add-member', '0:0:0:0:0:0:0:1', '内网IP', '{\"projectId\":\"1955984161988997122\",\"userId\":\"1955607159649886210\",\"memberRole\":\"普通成员\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-14 22:24:27', 447);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1955998990900457474, '000000', '更新成员角色', 2, 'org.dromara.hit.project.controller.HitProjectMemberController.updateMemberRole()', 'PUT', 1, 'admin', '研发部门', '/hit/project/member/role/1955998959283793921', '0:0:0:0:0:0:0:1', '内网IP', '{\"memberRole\":\"前端工程师\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-14 22:24:35', 174);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1956274849498603522, '000000', '用户技能关联', 1, 'org.dromara.hit.controller.HitUserSkillController.add()', 'POST', 1, 'zhangsan', 'XXX科技', '/hit/userSkill', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"userSkillId\":\"1956274848638771201\",\"userId\":\"1955607159649886210\",\"tagId\":1,\"skillLevel\":3,\"isCertified\":1,\"learningTime\":1,\"projectCount\":0,\"skillDescription\":null,\"certifiedTime\":null,\"certifiedRemark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-15 16:40:45', 209);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1956533970714046465, '000000', '项目点赞', 2, 'org.dromara.hit.project.controller.HitProjectController.like()', 'POST', 1, 'admin', '研发部门', '/hit/project/1955984161988997122/like', '0:0:0:0:0:0:0:1', '内网IP', '\"1955984161988997122\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-16 09:50:24', 207);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1956539010983944193, '000000', '项目信息', 2, 'org.dromara.hit.project.controller.HitProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/hit/project', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"projectId\":\"1955984161988997122\",\"projectName\":\"吹爆魔丸\",\"projectDescription\":\"吹爆我的魔丸！！！！！\",\"projectBackground\":\"魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸魔丸！！！\",\"projectGoals\":\"\",\"expectedOutcome\":\"\",\"coverImage\":\"http://123.56.113.24:9100/hit-bucket/2025/08/14/b8960fa9ca404aa6ac77d1940ca5c00b.png\",\"projectType\":\"competition\",\"projectCategory\":null,\"difficultyLevel\":2,\"durationType\":null,\"startDate\":\"2025-08-14\",\"endDate\":\"2025-08-29\",\"teamSizeMin\":null,\"teamSizeMax\":5,\"currentMembers\":null,\"status\":\"recruiting\",\"recruitmentStatus\":\"open\",\"visibility\":\"public\",\"approvalMode\":\"auto\",\"isFeatured\":\"0\",\"isUrgent\":\"0\",\"isCredit\":\"0\",\"creatorId\":null,\"mentorId\":null,\"deptId\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-16 10:10:26', 202);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1956539118400069633, '000000', '项目点赞', 2, 'org.dromara.hit.project.controller.HitProjectController.like()', 'POST', 1, 'admin', '研发部门', '/hit/project/1955984161988997122/like', '0:0:0:0:0:0:0:1', '内网IP', '\"1955984161988997122\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-16 10:10:51', 180);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1956539125190647809, '000000', '项目收藏', 2, 'org.dromara.hit.project.controller.HitProjectController.collect()', 'POST', 1, 'admin', '研发部门', '/hit/project/1955984161988997122/collect', '0:0:0:0:0:0:0:1', '内网IP', '\"1955984161988997122\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-16 10:10:53', 187);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1956557164963454977, '000000', '项目点赞', 2, 'org.dromara.hit.project.controller.HitProjectController.like()', 'POST', 1, 'admin', '研发部门', '/hit/project/1955984161988997122/like', '0:0:0:0:0:0:0:1', '内网IP', '\"1955984161988997122\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-16 11:22:34', 195);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1956557187805634562, '000000', '项目收藏', 2, 'org.dromara.hit.project.controller.HitProjectController.collect()', 'POST', 1, 'admin', '研发部门', '/hit/project/1955984161988997122/collect', '0:0:0:0:0:0:0:1', '内网IP', '\"1955984161988997122\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-16 11:22:39', 183);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1956557238145671170, '000000', '项目点赞', 2, 'org.dromara.hit.project.controller.HitProjectController.like()', 'POST', 1, 'admin', '研发部门', '/hit/project/1955984161988997122/like', '0:0:0:0:0:0:0:1', '内网IP', '\"1955984161988997122\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-16 11:22:51', 199);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1956557257187811330, '000000', '项目收藏', 2, 'org.dromara.hit.project.controller.HitProjectController.collect()', 'POST', 1, 'admin', '研发部门', '/hit/project/1955984161988997122/collect', '0:0:0:0:0:0:0:1', '内网IP', '\"1955984161988997122\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-16 11:22:56', 211);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1956557295053987841, '000000', '项目点赞', 2, 'org.dromara.hit.project.controller.HitProjectController.like()', 'POST', 1, 'admin', '研发部门', '/hit/project/1955984161988997122/like', '0:0:0:0:0:0:0:1', '内网IP', '\"1955984161988997122\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-16 11:23:05', 216);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1956557303518093314, '000000', '项目收藏', 2, 'org.dromara.hit.project.controller.HitProjectController.collect()', 'POST', 1, 'admin', '研发部门', '/hit/project/1955984161988997122/collect', '0:0:0:0:0:0:0:1', '内网IP', '\"1955984161988997122\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-16 11:23:07', 186);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1956558865262993409, '000000', '项目点赞', 2, 'org.dromara.hit.project.controller.HitProjectController.like()', 'POST', 1, 'admin', '研发部门', '/hit/project/1955984161988997122/like', '0:0:0:0:0:0:0:1', '内网IP', '\"1955984161988997122\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-16 11:29:19', 194);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1956558871780941825, '000000', '项目收藏', 2, 'org.dromara.hit.project.controller.HitProjectController.collect()', 'POST', 1, 'admin', '研发部门', '/hit/project/1955984161988997122/collect', '0:0:0:0:0:0:0:1', '内网IP', '\"1955984161988997122\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-16 11:29:21', 207);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1956558893071228930, '000000', '项目点赞', 2, 'org.dromara.hit.project.controller.HitProjectController.like()', 'POST', 1, 'admin', '研发部门', '/hit/project/1955984161988997122/like', '0:0:0:0:0:0:0:1', '内网IP', '\"1955984161988997122\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-16 11:29:26', 185);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1956558894639898625, '000000', '项目收藏', 2, 'org.dromara.hit.project.controller.HitProjectController.collect()', 'POST', 1, 'admin', '研发部门', '/hit/project/1955984161988997122/collect', '0:0:0:0:0:0:0:1', '内网IP', '\"1955984161988997122\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-16 11:29:26', 140);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1956558914504122369, '000000', '项目点赞', 2, 'org.dromara.hit.project.controller.HitProjectController.like()', 'POST', 1, 'admin', '研发部门', '/hit/project/1955984161988997122/like', '0:0:0:0:0:0:0:1', '内网IP', '\"1955984161988997122\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-16 11:29:31', 178);
INSERT INTO `sys_oper_log` (`oper_id`, `tenant_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (1956558916521582594, '000000', '项目收藏', 2, 'org.dromara.hit.project.controller.HitProjectController.collect()', 'POST', 1, 'admin', '研发部门', '/hit/project/1955984161988997122/collect', '0:0:0:0:0:0:0:1', '内网IP', '\"1955984161988997122\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-08-16 11:29:31', 123);
COMMIT;

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
BEGIN;
INSERT INTO `sys_oss` (`oss_id`, `tenant_id`, `file_name`, `original_name`, `file_suffix`, `url`, `ext1`, `create_dept`, `create_time`, `create_by`, `update_time`, `update_by`, `service`) VALUES (1955168819419090946, '000000', '2025/08/12/3989b432c73d4b19b83fec43c432f901.png', '萨摩耶.png', '.png', 'http://123.56.113.24:9100/hit-bucket/2025/08/12/3989b432c73d4b19b83fec43c432f901.png', NULL, 103, '2025-08-12 15:25:46', 1, '2025-08-12 15:25:46', 1, 'minio');
INSERT INTO `sys_oss` (`oss_id`, `tenant_id`, `file_name`, `original_name`, `file_suffix`, `url`, `ext1`, `create_dept`, `create_time`, `create_by`, `update_time`, `update_by`, `service`) VALUES (1955190533523828737, '000000', '2025/08/12/5dd92c1960434c1bbaf9e34e70267c6f.png', '鼠鼠.png', '.png', 'http://123.56.113.24:9100/hit-bucket/2025/08/12/5dd92c1960434c1bbaf9e34e70267c6f.png', NULL, 103, '2025-08-12 16:52:04', 1, '2025-08-12 16:52:04', 1, 'minio');
INSERT INTO `sys_oss` (`oss_id`, `tenant_id`, `file_name`, `original_name`, `file_suffix`, `url`, `ext1`, `create_dept`, `create_time`, `create_by`, `update_time`, `update_by`, `service`) VALUES (1955190631871868930, '000000', '2025/08/12/2c67facc35144614ae63f589c7c2857f.png', '鼠鼠.png', '.png', 'http://123.56.113.24:9100/hit-bucket/2025/08/12/2c67facc35144614ae63f589c7c2857f.png', NULL, 103, '2025-08-12 16:52:27', 1, '2025-08-12 16:52:27', 1, 'minio');
INSERT INTO `sys_oss` (`oss_id`, `tenant_id`, `file_name`, `original_name`, `file_suffix`, `url`, `ext1`, `create_dept`, `create_time`, `create_by`, `update_time`, `update_by`, `service`) VALUES (1955192982032625665, '000000', '2025/08/12/163fe40dbb604c289dd5753466e798fa.png', '萨摩耶.png', '.png', 'http://123.56.113.24:9100/hit-bucket/2025/08/12/163fe40dbb604c289dd5753466e798fa.png', NULL, 103, '2025-08-12 17:01:47', 1, '2025-08-12 17:01:47', 1, 'minio');
INSERT INTO `sys_oss` (`oss_id`, `tenant_id`, `file_name`, `original_name`, `file_suffix`, `url`, `ext1`, `create_dept`, `create_time`, `create_by`, `update_time`, `update_by`, `service`) VALUES (1955272909142671361, '000000', '2025/08/12/56c94addb07349f8ab4a75517590a22e.png', '萨摩耶.png', '.png', 'http://123.56.113.24:9100/hit-bucket/2025/08/12/56c94addb07349f8ab4a75517590a22e.png', NULL, 103, '2025-08-12 22:19:23', 1, '2025-08-12 22:19:23', 1, 'minio');
INSERT INTO `sys_oss` (`oss_id`, `tenant_id`, `file_name`, `original_name`, `file_suffix`, `url`, `ext1`, `create_dept`, `create_time`, `create_by`, `update_time`, `update_by`, `service`) VALUES (1955272983474126850, '000000', '2025/08/12/7bb076b32c524e10b5356a663dcf360c.png', '鼠鼠.png', '.png', 'http://123.56.113.24:9100/hit-bucket/2025/08/12/7bb076b32c524e10b5356a663dcf360c.png', NULL, 103, '2025-08-12 22:19:41', 1, '2025-08-12 22:19:41', 1, 'minio');
INSERT INTO `sys_oss` (`oss_id`, `tenant_id`, `file_name`, `original_name`, `file_suffix`, `url`, `ext1`, `create_dept`, `create_time`, `create_by`, `update_time`, `update_by`, `service`) VALUES (1955273353755672578, '000000', '2025/08/12/6da83a31d5084074a3df23b0b1b0a365.png', '机器人.png', '.png', 'http://123.56.113.24:9100/hit-bucket/2025/08/12/6da83a31d5084074a3df23b0b1b0a365.png', NULL, 103, '2025-08-12 22:21:09', 1, '2025-08-12 22:21:09', 1, 'minio');
INSERT INTO `sys_oss` (`oss_id`, `tenant_id`, `file_name`, `original_name`, `file_suffix`, `url`, `ext1`, `create_dept`, `create_time`, `create_by`, `update_time`, `update_by`, `service`) VALUES (1955969198419398657, '000000', '2025/08/14/02d4113189d5467aa230aa53b94832fa.png', '魔丸.png', '.png', 'http://123.56.113.24:9100/hit-bucket/2025/08/14/02d4113189d5467aa230aa53b94832fa.png', NULL, 103, '2025-08-14 20:26:12', 1, '2025-08-14 20:26:12', 1, 'minio');
INSERT INTO `sys_oss` (`oss_id`, `tenant_id`, `file_name`, `original_name`, `file_suffix`, `url`, `ext1`, `create_dept`, `create_time`, `create_by`, `update_time`, `update_by`, `service`) VALUES (1955970585253433346, '000000', '2025/08/14/19b403cbc39343d6aaf40efdf9adda76.png', '魔丸.png', '.png', 'http://123.56.113.24:9100/hit-bucket/2025/08/14/19b403cbc39343d6aaf40efdf9adda76.png', NULL, 103, '2025-08-14 20:31:42', 1, '2025-08-14 20:31:42', 1, 'minio');
INSERT INTO `sys_oss` (`oss_id`, `tenant_id`, `file_name`, `original_name`, `file_suffix`, `url`, `ext1`, `create_dept`, `create_time`, `create_by`, `update_time`, `update_by`, `service`) VALUES (1955983803644440577, '000000', '2025/08/14/b8960fa9ca404aa6ac77d1940ca5c00b.png', '魔丸.png', '.png', 'http://123.56.113.24:9100/hit-bucket/2025/08/14/b8960fa9ca404aa6ac77d1940ca5c00b.png', NULL, 103, '2025-08-14 21:24:14', 1, '2025-08-14 21:24:14', 1, 'minio');
COMMIT;

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
BEGIN;
INSERT INTO `sys_oss_config` (`oss_config_id`, `tenant_id`, `config_key`, `access_key`, `secret_key`, `bucket_name`, `prefix`, `endpoint`, `domain`, `is_https`, `region`, `access_policy`, `status`, `ext1`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '000000', 'minio', 'hitroot', 'hit@123456', 'hit-bucket', '', '123.56.113.24:9100', '', 'N', '', '1', '0', '', 103, 1, '2025-08-08 13:49:43', 1, '2025-08-12 16:51:46', '');
INSERT INTO `sys_oss_config` (`oss_config_id`, `tenant_id`, `config_key`, `access_key`, `secret_key`, `bucket_name`, `prefix`, `endpoint`, `domain`, `is_https`, `region`, `access_policy`, `status`, `ext1`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '000000', 'qiniu', 'XXXXXXXXXXXXXXX', 'XXXXXXXXXXXXXXX', 'ruoyi', '', 's3-cn-north-1.qiniucs.com', '', 'N', '', '1', '1', '', 103, 1, '2025-08-08 13:49:43', 1, '2025-08-08 13:49:43', NULL);
INSERT INTO `sys_oss_config` (`oss_config_id`, `tenant_id`, `config_key`, `access_key`, `secret_key`, `bucket_name`, `prefix`, `endpoint`, `domain`, `is_https`, `region`, `access_policy`, `status`, `ext1`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, '000000', 'aliyun', 'XXXXXXXXXXXXXXX', 'XXXXXXXXXXXXXXX', 'ruoyi', '', 'oss-cn-beijing.aliyuncs.com', '', 'N', '', '1', '1', '', 103, 1, '2025-08-08 13:49:43', 1, '2025-08-08 13:49:43', NULL);
INSERT INTO `sys_oss_config` (`oss_config_id`, `tenant_id`, `config_key`, `access_key`, `secret_key`, `bucket_name`, `prefix`, `endpoint`, `domain`, `is_https`, `region`, `access_policy`, `status`, `ext1`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4, '000000', 'qcloud', 'XXXXXXXXXXXXXXX', 'XXXXXXXXXXXXXXX', 'ruoyi-1240000000', '', 'cos.ap-beijing.myqcloud.com', '', 'N', 'ap-beijing', '1', '1', '', 103, 1, '2025-08-08 13:49:43', 1, '2025-08-08 13:49:43', NULL);
INSERT INTO `sys_oss_config` (`oss_config_id`, `tenant_id`, `config_key`, `access_key`, `secret_key`, `bucket_name`, `prefix`, `endpoint`, `domain`, `is_https`, `region`, `access_policy`, `status`, `ext1`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (5, '000000', 'image', 'ruoyi', 'ruoyi123', 'ruoyi', 'image', '127.0.0.1:9000', '', 'N', '', '1', '1', '', 103, 1, '2025-08-08 13:49:43', 1, '2025-08-08 13:49:43', NULL);
COMMIT;

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
BEGIN;
INSERT INTO `sys_post` (`post_id`, `tenant_id`, `dept_id`, `post_code`, `post_category`, `post_name`, `post_sort`, `status`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '000000', 103, 'ceo', NULL, '董事长', 1, '0', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_post` (`post_id`, `tenant_id`, `dept_id`, `post_code`, `post_category`, `post_name`, `post_sort`, `status`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '000000', 100, 'se', NULL, '项目经理', 2, '0', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_post` (`post_id`, `tenant_id`, `dept_id`, `post_code`, `post_category`, `post_name`, `post_sort`, `status`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, '000000', 100, 'hr', NULL, '人力资源', 3, '0', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
INSERT INTO `sys_post` (`post_id`, `tenant_id`, `dept_id`, `post_code`, `post_category`, `post_name`, `post_sort`, `status`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4, '000000', 100, 'user', NULL, '普通员工', 4, '0', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
COMMIT;

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
BEGIN;
INSERT INTO `sys_role` (`role_id`, `tenant_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '000000', '超级管理员', 'superadmin', 1, '1', 1, 1, '0', '0', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '超级管理员');
INSERT INTO `sys_role` (`role_id`, `tenant_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, '000000', '本部门及以下', 'test1', 3, '4', 1, 1, '0', '0', 103, 1, '2025-08-08 13:49:43', 1, '2025-08-14 16:20:11', '');
INSERT INTO `sys_role` (`role_id`, `tenant_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4, '000000', '仅本人', 'test2', 4, '5', 1, 1, '0', '0', 103, 1, '2025-08-08 13:49:43', NULL, NULL, '');
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 2001);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 2002);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 2003);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 2004);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 2005);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 2006);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 2011);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 2012);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 2013);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 2014);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 2015);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 2021);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 2022);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 2023);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 2024);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 2025);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 2031);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 2032);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 2033);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 2034);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 2035);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 2041);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 2042);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 2043);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 2044);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 2045);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 2051);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 2052);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 2053);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 3000);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 3001);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 3002);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 3007);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 3008);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 3009);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 3010);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 3011);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 3012);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 3101);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 3102);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 3103);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 3104);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 3105);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 3106);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 3107);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 3108);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 3109);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 3110);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 3111);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 3112);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (4, 5);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (4, 1500);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (4, 1501);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (4, 1502);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (4, 1503);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (4, 1504);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (4, 1505);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (4, 1506);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (4, 1507);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (4, 1508);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (4, 1509);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (4, 1510);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (4, 1511);
COMMIT;

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
BEGIN;
INSERT INTO `sys_social` (`id`, `user_id`, `tenant_id`, `auth_id`, `source`, `open_id`, `user_name`, `nick_name`, `email`, `avatar`, `access_token`, `expire_in`, `refresh_token`, `access_code`, `union_id`, `scope`, `token_type`, `id_token`, `mac_algorithm`, `mac_key`, `code`, `oauth_token`, `oauth_token_secret`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`) VALUES (1953827752140673026, 1953827752052592642, '000000', 'wechat_miniprogram_oIT4b6ZpkeWZemXbLzx-6J_1MChY', 'wechat_miniprogram', 'oIT4b6ZpkeWZemXbLzx-6J_1MChY', '', '', '', '', 'Zkd5z//suedM92WB3/EpLw==', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -1, -1, '2025-08-08 22:36:51', -1, '2025-08-08 22:36:51', '0');
COMMIT;

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
BEGIN;
INSERT INTO `sys_tenant` (`id`, `tenant_id`, `contact_user_name`, `contact_phone`, `company_name`, `license_number`, `address`, `intro`, `domain`, `remark`, `package_id`, `expire_time`, `account_count`, `status`, `del_flag`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1, '000000', '管理组', '15888888888', 'XXX有限公司', NULL, NULL, '多租户通用后台管理管理系统', NULL, NULL, NULL, NULL, -1, '0', '0', 103, 1, '2025-08-08 13:49:43', NULL, NULL);
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
INSERT INTO `sys_user` (`user_id`, `tenant_id`, `dept_id`, `user_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '000000', 103, 'admin', '迪迦', 'sys_user', '770276349@qq.com', '15888888888', '0', 1955168819419090946, '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '0:0:0:0:0:0:0:1', '2025-08-16 12:19:21', 103, 1, '2025-08-08 13:49:43', -1, '2025-08-16 12:19:21', '管理员');
INSERT INTO `sys_user` (`user_id`, `tenant_id`, `dept_id`, `user_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, '000000', 108, 'test', '本部门及以下 密码666666', 'sys_user', '', '', '0', NULL, '$2a$10$b8yUzN0C71sbz.PhNOCgJe.Tu1yWC3RNrTyjSQ8p1W0.aaUXUJ.Ne', '0', '0', '127.0.0.1', '2025-08-08 13:49:43', 103, 1, '2025-08-08 13:49:43', 3, '2025-08-08 13:49:43', NULL);
INSERT INTO `sys_user` (`user_id`, `tenant_id`, `dept_id`, `user_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4, '000000', 102, 'test1', '仅本人 密码666666', 'sys_user', '', '', '0', NULL, '$2a$10$b8yUzN0C71sbz.PhNOCgJe.Tu1yWC3RNrTyjSQ8p1W0.aaUXUJ.Ne', '0', '0', '127.0.0.1', '2025-08-08 13:49:43', 103, 1, '2025-08-08 13:49:43', 4, '2025-08-08 13:49:43', NULL);
INSERT INTO `sys_user` (`user_id`, `tenant_id`, `dept_id`, `user_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1953827752052592642, '000000', NULL, '18878688656', '用户863a0d', 'app_user', '', '18878688656', '0', NULL, '$2a$10$cH1XMJb4gN/GCy1EQDvLaefPyMhnRC0b66fLMUDOicl1fbkQNJUrq', '0', '0', '0:0:0:0:0:0:0:1', '2025-08-08 22:36:51', -1, -1, '2025-08-08 22:36:51', -1, '2025-08-08 22:36:51', NULL);
INSERT INTO `sys_user` (`user_id`, `tenant_id`, `dept_id`, `user_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1955607159649886210, '000000', 100, 'zhangsan', '张三', 'sys_user', '', '', '0', NULL, '$2a$10$.W47mg4RhIStcgNWoyvNcOm1ZujfE6q8YtwVgMLg9w7ht36tD9Gru', '0', '0', '0:0:0:0:0:0:0:1', '2025-08-15 17:44:45', 103, 1, '2025-08-13 20:27:35', -1, '2025-08-15 17:44:45', '');
INSERT INTO `sys_user` (`user_id`, `tenant_id`, `dept_id`, `user_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1955607220618289154, '000000', 100, 'lisi', '李四', 'sys_user', '', '', '0', NULL, '$2a$10$rNoSRbmIX9fKsbs8ZVPreO5B7WcOPW2hloSNWA/Kqx.FKbA3m0qA2', '0', '0', '', NULL, 103, 1, '2025-08-13 20:27:49', 1, '2025-08-13 20:27:49', '');
COMMIT;

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
BEGIN;
INSERT INTO `sys_user_post` (`user_id`, `post_id`) VALUES (1, 1);
COMMIT;

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
BEGIN;
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (1, 1);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (3, 3);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (4, 4);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (1955607159649886210, 3);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (1955607220618289154, 3);
COMMIT;

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
BEGIN;
INSERT INTO `test_demo` (`id`, `tenant_id`, `dept_id`, `user_id`, `order_num`, `test_key`, `value`, `version`, `create_dept`, `create_time`, `create_by`, `update_time`, `update_by`, `del_flag`) VALUES (1, '000000', 102, 4, 1, '测试数据权限', '测试', 0, 103, '2025-08-08 13:49:44', 1, NULL, NULL, 0);
INSERT INTO `test_demo` (`id`, `tenant_id`, `dept_id`, `user_id`, `order_num`, `test_key`, `value`, `version`, `create_dept`, `create_time`, `create_by`, `update_time`, `update_by`, `del_flag`) VALUES (2, '000000', 102, 3, 2, '子节点1', '111', 0, 103, '2025-08-08 13:49:44', 1, NULL, NULL, 0);
INSERT INTO `test_demo` (`id`, `tenant_id`, `dept_id`, `user_id`, `order_num`, `test_key`, `value`, `version`, `create_dept`, `create_time`, `create_by`, `update_time`, `update_by`, `del_flag`) VALUES (3, '000000', 102, 3, 3, '子节点2', '222', 0, 103, '2025-08-08 13:49:44', 1, NULL, NULL, 0);
INSERT INTO `test_demo` (`id`, `tenant_id`, `dept_id`, `user_id`, `order_num`, `test_key`, `value`, `version`, `create_dept`, `create_time`, `create_by`, `update_time`, `update_by`, `del_flag`) VALUES (4, '000000', 108, 4, 4, '测试数据', 'demo', 0, 103, '2025-08-08 13:49:44', 1, NULL, NULL, 0);
INSERT INTO `test_demo` (`id`, `tenant_id`, `dept_id`, `user_id`, `order_num`, `test_key`, `value`, `version`, `create_dept`, `create_time`, `create_by`, `update_time`, `update_by`, `del_flag`) VALUES (5, '000000', 108, 3, 13, '子节点11', '1111', 0, 103, '2025-08-08 13:49:44', 1, NULL, NULL, 0);
INSERT INTO `test_demo` (`id`, `tenant_id`, `dept_id`, `user_id`, `order_num`, `test_key`, `value`, `version`, `create_dept`, `create_time`, `create_by`, `update_time`, `update_by`, `del_flag`) VALUES (6, '000000', 108, 3, 12, '子节点22', '2222', 0, 103, '2025-08-08 13:49:44', 1, NULL, NULL, 0);
INSERT INTO `test_demo` (`id`, `tenant_id`, `dept_id`, `user_id`, `order_num`, `test_key`, `value`, `version`, `create_dept`, `create_time`, `create_by`, `update_time`, `update_by`, `del_flag`) VALUES (7, '000000', 108, 3, 11, '子节点33', '3333', 0, 103, '2025-08-08 13:49:44', 1, NULL, NULL, 0);
INSERT INTO `test_demo` (`id`, `tenant_id`, `dept_id`, `user_id`, `order_num`, `test_key`, `value`, `version`, `create_dept`, `create_time`, `create_by`, `update_time`, `update_by`, `del_flag`) VALUES (8, '000000', 108, 3, 10, '子节点44', '4444', 0, 103, '2025-08-08 13:49:44', 1, NULL, NULL, 0);
INSERT INTO `test_demo` (`id`, `tenant_id`, `dept_id`, `user_id`, `order_num`, `test_key`, `value`, `version`, `create_dept`, `create_time`, `create_by`, `update_time`, `update_by`, `del_flag`) VALUES (9, '000000', 108, 3, 9, '子节点55', '5555', 0, 103, '2025-08-08 13:49:44', 1, NULL, NULL, 0);
INSERT INTO `test_demo` (`id`, `tenant_id`, `dept_id`, `user_id`, `order_num`, `test_key`, `value`, `version`, `create_dept`, `create_time`, `create_by`, `update_time`, `update_by`, `del_flag`) VALUES (10, '000000', 108, 3, 8, '子节点66', '6666', 0, 103, '2025-08-08 13:49:44', 1, NULL, NULL, 0);
INSERT INTO `test_demo` (`id`, `tenant_id`, `dept_id`, `user_id`, `order_num`, `test_key`, `value`, `version`, `create_dept`, `create_time`, `create_by`, `update_time`, `update_by`, `del_flag`) VALUES (11, '000000', 108, 3, 7, '子节点77', '7777', 0, 103, '2025-08-08 13:49:44', 1, NULL, NULL, 0);
INSERT INTO `test_demo` (`id`, `tenant_id`, `dept_id`, `user_id`, `order_num`, `test_key`, `value`, `version`, `create_dept`, `create_time`, `create_by`, `update_time`, `update_by`, `del_flag`) VALUES (12, '000000', 108, 3, 6, '子节点88', '8888', 0, 103, '2025-08-08 13:49:44', 1, NULL, NULL, 0);
INSERT INTO `test_demo` (`id`, `tenant_id`, `dept_id`, `user_id`, `order_num`, `test_key`, `value`, `version`, `create_dept`, `create_time`, `create_by`, `update_time`, `update_by`, `del_flag`) VALUES (13, '000000', 108, 3, 5, '子节点99', '9999', 0, 103, '2025-08-08 13:49:44', 1, NULL, NULL, 0);
COMMIT;

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
BEGIN;
COMMIT;

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
BEGIN;
INSERT INTO `test_tree` (`id`, `tenant_id`, `parent_id`, `dept_id`, `user_id`, `tree_name`, `version`, `create_dept`, `create_time`, `create_by`, `update_time`, `update_by`, `del_flag`) VALUES (1, '000000', 0, 102, 4, '测试数据权限', 0, 103, '2025-08-08 13:49:44', 1, NULL, NULL, 0);
INSERT INTO `test_tree` (`id`, `tenant_id`, `parent_id`, `dept_id`, `user_id`, `tree_name`, `version`, `create_dept`, `create_time`, `create_by`, `update_time`, `update_by`, `del_flag`) VALUES (2, '000000', 1, 102, 3, '子节点1', 0, 103, '2025-08-08 13:49:44', 1, NULL, NULL, 0);
INSERT INTO `test_tree` (`id`, `tenant_id`, `parent_id`, `dept_id`, `user_id`, `tree_name`, `version`, `create_dept`, `create_time`, `create_by`, `update_time`, `update_by`, `del_flag`) VALUES (3, '000000', 2, 102, 3, '子节点2', 0, 103, '2025-08-08 13:49:44', 1, NULL, NULL, 0);
INSERT INTO `test_tree` (`id`, `tenant_id`, `parent_id`, `dept_id`, `user_id`, `tree_name`, `version`, `create_dept`, `create_time`, `create_by`, `update_time`, `update_by`, `del_flag`) VALUES (4, '000000', 0, 108, 4, '测试树1', 0, 103, '2025-08-08 13:49:44', 1, NULL, NULL, 0);
INSERT INTO `test_tree` (`id`, `tenant_id`, `parent_id`, `dept_id`, `user_id`, `tree_name`, `version`, `create_dept`, `create_time`, `create_by`, `update_time`, `update_by`, `del_flag`) VALUES (5, '000000', 4, 108, 3, '子节点11', 0, 103, '2025-08-08 13:49:44', 1, NULL, NULL, 0);
INSERT INTO `test_tree` (`id`, `tenant_id`, `parent_id`, `dept_id`, `user_id`, `tree_name`, `version`, `create_dept`, `create_time`, `create_by`, `update_time`, `update_by`, `del_flag`) VALUES (6, '000000', 4, 108, 3, '子节点22', 0, 103, '2025-08-08 13:49:44', 1, NULL, NULL, 0);
INSERT INTO `test_tree` (`id`, `tenant_id`, `parent_id`, `dept_id`, `user_id`, `tree_name`, `version`, `create_dept`, `create_time`, `create_by`, `update_time`, `update_by`, `del_flag`) VALUES (7, '000000', 4, 108, 3, '子节点33', 0, 103, '2025-08-08 13:49:44', 1, NULL, NULL, 0);
INSERT INTO `test_tree` (`id`, `tenant_id`, `parent_id`, `dept_id`, `user_id`, `tree_name`, `version`, `create_dept`, `create_time`, `create_by`, `update_time`, `update_by`, `del_flag`) VALUES (8, '000000', 5, 108, 3, '子节点44', 0, 103, '2025-08-08 13:49:44', 1, NULL, NULL, 0);
INSERT INTO `test_tree` (`id`, `tenant_id`, `parent_id`, `dept_id`, `user_id`, `tree_name`, `version`, `create_dept`, `create_time`, `create_by`, `update_time`, `update_by`, `del_flag`) VALUES (9, '000000', 6, 108, 3, '子节点55', 0, 103, '2025-08-08 13:49:44', 1, NULL, NULL, 0);
INSERT INTO `test_tree` (`id`, `tenant_id`, `parent_id`, `dept_id`, `user_id`, `tree_name`, `version`, `create_dept`, `create_time`, `create_by`, `update_time`, `update_by`, `del_flag`) VALUES (10, '000000', 7, 108, 3, '子节点66', 0, 103, '2025-08-08 13:49:44', 1, NULL, NULL, 0);
INSERT INTO `test_tree` (`id`, `tenant_id`, `parent_id`, `dept_id`, `user_id`, `tree_name`, `version`, `create_dept`, `create_time`, `create_by`, `update_time`, `update_by`, `del_flag`) VALUES (11, '000000', 7, 108, 3, '子节点77', 0, 103, '2025-08-08 13:49:44', 1, NULL, NULL, 0);
INSERT INTO `test_tree` (`id`, `tenant_id`, `parent_id`, `dept_id`, `user_id`, `tree_name`, `version`, `create_dept`, `create_time`, `create_by`, `update_time`, `update_by`, `del_flag`) VALUES (12, '000000', 10, 108, 3, '子节点88', 0, 103, '2025-08-08 13:49:44', 1, NULL, NULL, 0);
INSERT INTO `test_tree` (`id`, `tenant_id`, `parent_id`, `dept_id`, `user_id`, `tree_name`, `version`, `create_dept`, `create_time`, `create_by`, `update_time`, `update_by`, `del_flag`) VALUES (13, '000000', 10, 108, 3, '子节点99', 0, 103, '2025-08-08 13:49:44', 1, NULL, NULL, 0);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
