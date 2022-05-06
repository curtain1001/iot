/*
 Navicat Premium Data Transfer

 Source Server         : wumei.live
 Source Server Type    : MySQL
 Source Server Version : 50734
 Source Host           : wumei.live:3306
 Source Schema         : wumei-smart

 Target Server Type    : MySQL
 Target Server Version : 50734
 File Encoding         : 65001

 Date: 22/04/2022 01:33:54
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for QRTZ_BLOB_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
CREATE TABLE `QRTZ_BLOB_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Blob类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_BLOB_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_CALENDARS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
CREATE TABLE `QRTZ_CALENDARS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '日历信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_CALENDARS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_CRON_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
CREATE TABLE `QRTZ_CRON_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Cron类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_CRON_TRIGGERS
-- ----------------------------
INSERT INTO `QRTZ_CRON_TRIGGERS` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', '0 20 10 ? * 1,2,3,4,5,6,7', 'Asia/Shanghai');

-- ----------------------------
-- Table structure for QRTZ_FIRED_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
CREATE TABLE `QRTZ_FIRED_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint(13) NOT NULL COMMENT '触发的时间',
  `sched_time` bigint(13) NOT NULL COMMENT '定时器制定的时间',
  `priority` int(11) NOT NULL COMMENT '优先级',
  `state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '已触发的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_FIRED_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_JOB_DETAILS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
CREATE TABLE `QRTZ_JOB_DETAILS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '任务详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_JOB_DETAILS
-- ----------------------------
INSERT INTO `QRTZ_JOB_DETAILS` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', NULL, 'com.ruoyi.iot.util.quartz.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F504552544945537372001E636F6D2E72756F79692E696F742E646F6D61696E2E4465766963654A6F6200000000000000010200114C0007616374696F6E737400124C6A6176612F6C616E672F537472696E673B4C0007616C65727449647400104C6A6176612F6C616E672F4C6F6E673B4C000A636F6E63757272656E7471007E00094C000E63726F6E45787072657373696F6E71007E00094C0008646576696365496471007E000A4C000A6465766963654E616D6571007E00094C00096973416476616E63657400134C6A6176612F6C616E672F496E74656765723B4C00086A6F6247726F757071007E00094C00056A6F62496471007E000A4C00076A6F624E616D6571007E00094C00076A6F625479706571007E000B4C000D6D697366697265506F6C69637971007E00094C000970726F64756374496471007E000A4C000B70726F647563744E616D6571007E00094C00077363656E65496471007E000A4C000C73657269616C4E756D62657271007E00094C000673746174757371007E000978720027636F6D2E72756F79692E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000D787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017F8E04515078707400007070707401F55B7B226964223A20227265706F72745F6D6F6E69746F72222C20226E616D65223A2022E4B88AE68AA5E79B91E6B58BE695B0E68DAE222C202274797065223A20322C202276616C7565223A202231222C2022736F75726365223A20322C20226465766963654964223A20332C2022616C6572744E616D65223A2022222C2022616C6572744C6576656C223A20312C20226465766963654E616D65223A202245535038323636E5BC80E58F91E69DBF227D2C207B226964223A2022737769746368222C20226E616D65223A2022E8AEBEE5A487E5BC80E585B3222C202274797065223A20322C202276616C7565223A202231222C2022736F75726365223A20322C20226465766963654964223A20332C2022616C6572744E616D65223A2022222C2022616C6572744C6576656C223A20312C20226465766963654E616D65223A202245535038323636E5BC80E58F91E69DBF227D2C207B226964223A202267656172222C20226E616D65223A2022E8BF90E8A18CE6A1A3E4BD8D222C202274797065223A20322C202276616C7565223A202233222C2022736F75726365223A20322C20226465766963654964223A20332C2022616C6572744E616D65223A2022222C2022616C6572744C6576656C223A20312C20226465766963654E616D65223A202245535038323636E5BC80E58F91E69DBF227D5D707400013174001930203230203130203F202A20312C322C332C342C352C362C377372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000000374001045535038323636E5BC80E58F91E69DBF737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E00170000000074000744454641554C547371007E00160000000000000001740018E5AE9AE697B6E4B88AE68AA5E79B91E6B58BE695B0E68DAE7371007E001A00000001740001327371007E0016000000000000000274001345535038323636E4BAA7E59381E7A4BAE4BE8B707400104436333239564C35343431394C315930740001307800);

-- ----------------------------
-- Table structure for QRTZ_LOCKS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_LOCKS`;
CREATE TABLE `QRTZ_LOCKS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '存储的悲观锁信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_LOCKS
-- ----------------------------
INSERT INTO `QRTZ_LOCKS` VALUES ('RuoyiScheduler', 'STATE_ACCESS');
INSERT INTO `QRTZ_LOCKS` VALUES ('RuoyiScheduler', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '暂停的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SCHEDULER_STATE
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
CREATE TABLE `QRTZ_SCHEDULER_STATE`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint(13) NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint(13) NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '调度器状态表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_SCHEDULER_STATE
-- ----------------------------
INSERT INTO `QRTZ_SCHEDULER_STATE` VALUES ('RuoyiScheduler', 'DESKTOP-KKH3KAT1650559591596', 1650562435320, 15000);

-- ----------------------------
-- Table structure for QRTZ_SIMPLE_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint(7) NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint(12) NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint(10) NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '简单触发器的信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_SIMPLE_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SIMPROP_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPROP_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPROP_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int(11) NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int(11) NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint(20) NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint(20) NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPROP_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '同步机制的行锁表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_SIMPROP_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
CREATE TABLE `QRTZ_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint(13) NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint(13) NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int(11) NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint(13) NOT NULL COMMENT '开始时间',
  `end_time` bigint(13) NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint(2) NULL DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name`, `job_name`, `job_group`) USING BTREE,
  CONSTRAINT `QRTZ_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `QRTZ_JOB_DETAILS` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '触发器详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_TRIGGERS
-- ----------------------------
INSERT INTO `QRTZ_TRIGGERS` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', 'TASK_CLASS_NAME1', 'DEFAULT', NULL, 1650594000000, -1, 5, 'WAITING', 'CRON', 1650559600000, 0, NULL, 1, '');

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (1, 'iot_category', '产品分类', '', '', 'Category', 'crud', 'com.ruoyi.iot', 'iot', 'category', '产品分类', 'kerwincui', '0', '/', '{\"treeCode\":\"category_id\",\"treeName\":\"category_name\",\"treeParentCode\":\"parent_id\",\"parentMenuId\":\"2000\"}', 'admin', '2021-12-15 22:56:19', '', '2021-12-20 14:35:01', NULL);
INSERT INTO `gen_table` VALUES (2, 'iot_device', '设备', NULL, NULL, 'Device', 'crud', 'com.ruoyi.iot', 'iot', 'device', '设备', 'kerwincui', '0', '/', '{\"parentMenuId\":\"2000\"}', 'admin', '2021-12-15 22:56:21', '', '2021-12-16 00:23:18', NULL);
INSERT INTO `gen_table` VALUES (5, 'iot_device_user', '设备用户', NULL, NULL, 'DeviceUser', 'crud', 'com.ruoyi.iot', 'iot', 'deviceuser', '设备用户', 'kerwincui', '0', '/', '{\"parentMenuId\":\"2000\"}', 'admin', '2021-12-15 22:56:29', '', '2021-12-16 01:16:47', NULL);
INSERT INTO `gen_table` VALUES (7, 'iot_firmware', '产品固件', NULL, NULL, 'Firmware', 'crud', 'com.ruoyi.iot', 'iot', 'firmware', '产品固件', 'kerwincui', '0', '/', '{\"parentMenuId\":2000}', 'admin', '2021-12-15 22:56:31', '', '2021-12-16 00:18:09', NULL);
INSERT INTO `gen_table` VALUES (9, 'iot_group', '设备分组', NULL, NULL, 'Group', 'crud', 'com.ruoyi.iot', 'iot', 'group', '设备分组', 'kerwincui', '0', '/', '{\"parentMenuId\":2000}', 'admin', '2021-12-15 22:56:34', '', '2021-12-16 00:31:15', NULL);
INSERT INTO `gen_table` VALUES (11, 'iot_product', '产品', NULL, NULL, 'Product', 'crud', 'com.ruoyi.iot', 'iot', 'product', '产品', 'kerwincui', '0', '/', '{\"parentMenuId\":2000}', 'admin', '2021-12-15 22:56:37', '', '2021-12-16 00:22:11', NULL);
INSERT INTO `gen_table` VALUES (13, 'iot_things_model', '物模型', NULL, NULL, 'ThingsModel', 'crud', 'com.ruoyi.iot', 'iot', 'model', '物模型', 'kerwincui', '0', '/', '{\"parentMenuId\":2000}', 'admin', '2021-12-15 22:56:40', '', '2021-12-16 00:29:39', NULL);
INSERT INTO `gen_table` VALUES (15, 'iot_things_model_template', '通用物模型', NULL, NULL, 'ThingsModelTemplate', 'crud', 'com.ruoyi.iot', 'iot', 'template', '通用物模型', 'kerwincui', '0', '/', '{\"parentMenuId\":2000}', 'admin', '2021-12-15 22:56:44', '', '2021-12-16 00:26:56', NULL);
INSERT INTO `gen_table` VALUES (20, 'iot_alert', '设备告警', NULL, NULL, 'Alert', 'crud', 'com.ruoyi.iot', 'iot', 'alert', '设备告警', 'kerwincui', '0', '/', '{}', 'admin', '2022-01-13 14:53:24', '', '2022-01-13 15:16:02', NULL);
INSERT INTO `gen_table` VALUES (21, 'iot_alert_log', '设备告警日志', NULL, NULL, 'AlertLog', 'crud', 'com.ruoyi.iot', 'iot', 'alertLog', '设备告警', 'kerwincui', '0', '/', '{\"parentMenuId\":\"2000\"}', 'admin', '2022-01-13 14:53:27', '', '2022-01-13 15:16:32', NULL);
INSERT INTO `gen_table` VALUES (22, 'iot_device_log', '设备日志', NULL, NULL, 'DeviceLog', 'crud', 'com.ruoyi.iot', 'iot', 'deviceLog', '设备日志', 'kerwincui', '0', '/', '{}', 'admin', '2022-01-13 14:53:30', '', '2022-01-13 15:17:15', NULL);
INSERT INTO `gen_table` VALUES (23, 'iot_scene', '场景联动', NULL, NULL, 'Scene', 'crud', 'com.ruoyi.iot', 'iot', 'scene', '场景联动', 'kerwincui', '0', '/', '{\"parentMenuId\":\"2000\"}', 'admin', '2022-01-13 14:53:33', '', '2022-01-13 15:17:37', NULL);
INSERT INTO `gen_table` VALUES (25, 'iot_device_job', '设备定时', NULL, NULL, 'DeviceJob', 'crud', 'com.ruoyi.iot', 'iot', 'job', '设备定时', 'kerwincui', '0', '/', NULL, 'admin', '2022-01-17 16:18:25', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (26, 'iot_device_group', '设备分组', NULL, NULL, 'DeviceGroup', 'crud', 'com.ruoyi.iot', 'iot', 'group', '设备分组', 'kerwincui', '0', '/', NULL, 'admin', '2022-01-24 00:29:24', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (27, 'oauth_client_details', '云云对接', NULL, NULL, 'OauthClientDetails', 'crud', 'com.ruoyi.iot', 'iot', 'clientDetails', '云云对接', 'kerwincui', '0', '/', '{\"parentMenuId\":\"2000\"}', 'admin', '2022-02-07 20:24:16', '', '2022-02-07 20:38:11', NULL);
INSERT INTO `gen_table` VALUES (33, 'news', '新闻资讯', NULL, NULL, 'News', 'crud', 'com.ruoyi.iot', 'iot', 'news', '新闻资讯', 'kerwincui', '0', '/', '{\"parentMenuId\":1}', 'admin', '2022-04-09 19:15:19', '', '2022-04-09 19:20:56', NULL);
INSERT INTO `gen_table` VALUES (34, 'news_category', '新闻分类', NULL, NULL, 'NewsCategory', 'crud', 'com.ruoyi.iot', 'iot', 'category', '新闻分类', 'kerwincui', '0', '/', '{\"parentMenuId\":1}', 'admin', '2022-04-09 19:15:23', '', '2022-04-09 19:23:45', NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 501 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (1, '1', 'category_id', '产品分类ID', 'bigint(20)', 'Long', 'categoryId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-12-15 22:56:19', '', '2021-12-20 14:35:01');
INSERT INTO `gen_table_column` VALUES (2, '1', 'category_name', '产品分类名称', 'varchar(64)', 'String', 'categoryName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2021-12-15 22:56:19', '', '2021-12-20 14:35:02');
INSERT INTO `gen_table_column` VALUES (3, '1', 'tenant_id', '租户ID', 'bigint(20)', 'Long', 'tenantId', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 3, 'admin', '2021-12-15 22:56:19', '', '2021-12-20 14:35:02');
INSERT INTO `gen_table_column` VALUES (4, '1', 'tenant_name', '租户名称', 'varchar(30)', 'String', 'tenantName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 4, 'admin', '2021-12-15 22:56:19', '', '2021-12-20 14:35:02');
INSERT INTO `gen_table_column` VALUES (5, '1', 'is_sys', '是否系统通用（0-否，1-是）', 'tinyint(1)', 'Integer', 'isSys', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', 'iot_yes_no', 5, 'admin', '2021-12-15 22:56:19', '', '2021-12-20 14:35:02');
INSERT INTO `gen_table_column` VALUES (6, '1', 'parent_id', '父级ID', 'bigint(20)', 'Long', 'parentId', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 6, 'admin', '2021-12-15 22:56:20', '', '2021-12-20 14:35:02');
INSERT INTO `gen_table_column` VALUES (7, '1', 'order_num', '显示顺序', 'int(4)', 'Integer', 'orderNum', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 7, 'admin', '2021-12-15 22:56:20', '', '2021-12-20 14:35:02');
INSERT INTO `gen_table_column` VALUES (8, '1', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 8, 'admin', '2021-12-15 22:56:20', '', '2021-12-20 14:35:02');
INSERT INTO `gen_table_column` VALUES (9, '1', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2021-12-15 22:56:20', '', '2021-12-20 14:35:03');
INSERT INTO `gen_table_column` VALUES (10, '1', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, '1', NULL, 'EQ', 'datetime', '', 10, 'admin', '2021-12-15 22:56:20', '', '2021-12-20 14:35:03');
INSERT INTO `gen_table_column` VALUES (11, '1', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 11, 'admin', '2021-12-15 22:56:20', '', '2021-12-20 14:35:03');
INSERT INTO `gen_table_column` VALUES (12, '1', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 12, 'admin', '2021-12-15 22:56:21', '', '2021-12-20 14:35:03');
INSERT INTO `gen_table_column` VALUES (13, '1', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 13, 'admin', '2021-12-15 22:56:21', '', '2021-12-20 14:35:03');
INSERT INTO `gen_table_column` VALUES (14, '2', 'device_id', '产品分类ID', 'bigint(20)', 'Long', 'deviceId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-12-15 22:56:21', '', '2021-12-16 00:23:18');
INSERT INTO `gen_table_column` VALUES (15, '2', 'device_name', '产品分类名称', 'varchar(64)', 'String', 'deviceName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2021-12-15 22:56:21', '', '2021-12-16 00:23:19');
INSERT INTO `gen_table_column` VALUES (16, '2', 'product_id', '产品ID', 'bigint(20)', 'Long', 'productId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2021-12-15 22:56:21', '', '2021-12-16 00:23:19');
INSERT INTO `gen_table_column` VALUES (17, '2', 'product_name', '产品名称', 'varchar(64)', 'String', 'productName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 4, 'admin', '2021-12-15 22:56:22', '', '2021-12-16 00:23:19');
INSERT INTO `gen_table_column` VALUES (18, '2', 'user_id', '用户ID', 'bigint(20)', 'Long', 'userId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2021-12-15 22:56:22', '', '2021-12-16 00:23:19');
INSERT INTO `gen_table_column` VALUES (19, '2', 'user_name', '用户昵称', 'varchar(30)', 'String', 'userName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 6, 'admin', '2021-12-15 22:56:22', '', '2021-12-16 00:23:19');
INSERT INTO `gen_table_column` VALUES (20, '2', 'tenant_id', '租户ID', 'bigint(20)', 'Long', 'tenantId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2021-12-15 22:56:22', '', '2021-12-16 00:23:19');
INSERT INTO `gen_table_column` VALUES (21, '2', 'tenant_name', '租户名称', 'varchar(30)', 'String', 'tenantName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 8, 'admin', '2021-12-15 22:56:23', '', '2021-12-16 00:23:19');
INSERT INTO `gen_table_column` VALUES (22, '2', 'serial_number', '设备编号', 'varchar(64)', 'String', 'serialNumber', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admin', '2021-12-15 22:56:23', '', '2021-12-16 00:23:20');
INSERT INTO `gen_table_column` VALUES (23, '2', 'firmware_version', '固件版本', 'float(11,2)', 'BigDecimal', 'firmwareVersion', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 10, 'admin', '2021-12-15 22:56:23', '', '2021-12-16 00:23:20');
INSERT INTO `gen_table_column` VALUES (24, '2', 'status', '设备状态（1-未激活，2-禁用，3-在线，4-离线）', 'tinyint(1)', 'Integer', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', 'iot_yes_no', 11, 'admin', '2021-12-15 22:56:23', '', '2021-12-16 00:23:20');
INSERT INTO `gen_table_column` VALUES (26, '2', 'rssi', 'wifi信号强度（\r\n信号极好4格[-55— 0]，\r\n信号好3格[-70— -55]，\r\n信号一般2格[-85— -70]，\r\n信号差1格[-100— -85]）', 'varchar(255)', 'Integer', 'rssi', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 13, 'admin', '2021-12-15 22:56:23', '', '2021-12-16 00:23:20');
INSERT INTO `gen_table_column` VALUES (27, '2', 'network_address', '设备所在地址', 'varchar(255)', 'String', 'networkAddress', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 14, 'admin', '2021-12-15 22:56:23', '', '2021-12-16 00:23:20');
INSERT INTO `gen_table_column` VALUES (28, '2', 'network_ip', '设备入网IP', 'varchar(32)', 'String', 'networkIp', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 15, 'admin', '2021-12-15 22:56:24', '', '2021-12-16 00:23:21');
INSERT INTO `gen_table_column` VALUES (29, '2', 'longitude', '设备经度', 'double(11,0)', 'Long', 'longitude', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 16, 'admin', '2021-12-15 22:56:24', '', '2021-12-16 00:23:21');
INSERT INTO `gen_table_column` VALUES (30, '2', 'latitude', '设备纬度', 'double(11,0)', 'Long', 'latitude', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 17, 'admin', '2021-12-15 22:56:24', '', '2021-12-16 00:23:21');
INSERT INTO `gen_table_column` VALUES (31, '2', 'active_time', '激活时间', 'datetime', 'Date', 'activeTime', '0', '0', NULL, '1', '1', '1', '1', 'BETWEEN', 'datetime', '', 18, 'admin', '2021-12-15 22:56:24', '', '2021-12-16 00:23:21');
INSERT INTO `gen_table_column` VALUES (32, '2', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 19, 'admin', '2021-12-15 22:56:24', '', '2021-12-16 00:23:21');
INSERT INTO `gen_table_column` VALUES (33, '2', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 20, 'admin', '2021-12-15 22:56:24', '', '2021-12-16 00:23:21');
INSERT INTO `gen_table_column` VALUES (34, '2', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, '1', NULL, 'EQ', 'datetime', '', 21, 'admin', '2021-12-15 22:56:25', '', '2021-12-16 00:23:21');
INSERT INTO `gen_table_column` VALUES (35, '2', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 22, 'admin', '2021-12-15 22:56:25', '', '2021-12-16 00:23:22');
INSERT INTO `gen_table_column` VALUES (36, '2', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 23, 'admin', '2021-12-15 22:56:25', '', '2021-12-16 00:23:22');
INSERT INTO `gen_table_column` VALUES (37, '2', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 24, 'admin', '2021-12-15 22:56:25', '', '2021-12-16 00:23:22');
INSERT INTO `gen_table_column` VALUES (70, '5', 'device_id', '固件ID', 'bigint(20)', 'Long', 'deviceId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-12-15 22:56:29', '', '2021-12-16 01:16:47');
INSERT INTO `gen_table_column` VALUES (71, '5', 'user_id', '用户ID', 'bigint(20)', 'Long', 'userId', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 2, 'admin', '2021-12-15 22:56:29', '', '2021-12-16 01:16:47');
INSERT INTO `gen_table_column` VALUES (73, '5', 'device_name', '设备名称', 'varchar(64)', 'String', 'deviceName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 'admin', '2021-12-15 22:56:29', '', '2021-12-16 01:16:47');
INSERT INTO `gen_table_column` VALUES (75, '5', 'user_name', '用户昵称', 'varchar(30)', 'String', 'userName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 4, 'admin', '2021-12-15 22:56:29', '', '2021-12-16 01:16:47');
INSERT INTO `gen_table_column` VALUES (77, '5', 'tenant_id', '租户ID', 'bigint(20)', 'Long', 'tenantId', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 5, 'admin', '2021-12-15 22:56:29', '', '2021-12-16 01:16:48');
INSERT INTO `gen_table_column` VALUES (79, '5', 'tenant_name', '租户名称', 'varchar(30)', 'String', 'tenantName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 6, 'admin', '2021-12-15 22:56:30', '', '2021-12-16 01:16:48');
INSERT INTO `gen_table_column` VALUES (81, '5', 'is_owner', '是否为设备所有者', 'tinyint(11)', 'Long', 'isOwner', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', 'iot_yes_no', 7, 'admin', '2021-12-15 22:56:30', '', '2021-12-16 01:16:48');
INSERT INTO `gen_table_column` VALUES (85, '5', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2021-12-15 22:56:30', '', '2021-12-16 01:16:48');
INSERT INTO `gen_table_column` VALUES (87, '5', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 10, 'admin', '2021-12-15 22:56:30', '', '2021-12-16 01:16:48');
INSERT INTO `gen_table_column` VALUES (89, '5', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, '1', NULL, 'EQ', 'datetime', '', 11, 'admin', '2021-12-15 22:56:30', '', '2021-12-16 01:16:49');
INSERT INTO `gen_table_column` VALUES (91, '5', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 12, 'admin', '2021-12-15 22:56:31', '', '2021-12-16 01:16:49');
INSERT INTO `gen_table_column` VALUES (93, '5', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 13, 'admin', '2021-12-15 22:56:31', '', '2021-12-16 01:16:49');
INSERT INTO `gen_table_column` VALUES (95, '5', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 14, 'admin', '2021-12-15 22:56:31', '', '2021-12-16 01:16:49');
INSERT INTO `gen_table_column` VALUES (99, '7', 'firmware_id', '固件ID', 'bigint(20)', 'Long', 'firmwareId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-12-15 22:56:31', '', '2021-12-16 00:18:09');
INSERT INTO `gen_table_column` VALUES (101, '7', 'firmware_name', '固件名称', 'varchar(64)', 'String', 'firmwareName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2021-12-15 22:56:32', '', '2021-12-16 00:18:09');
INSERT INTO `gen_table_column` VALUES (103, '7', 'product_id', '产品ID', 'bigint(20)', 'Long', 'productId', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 3, 'admin', '2021-12-15 22:56:32', '', '2021-12-16 00:18:09');
INSERT INTO `gen_table_column` VALUES (105, '7', 'product_name', '产品名称', 'varchar(64)', 'String', 'productName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 4, 'admin', '2021-12-15 22:56:32', '', '2021-12-16 00:18:09');
INSERT INTO `gen_table_column` VALUES (107, '7', 'tenant_id', '租户ID', 'bigint(20)', 'Long', 'tenantId', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 5, 'admin', '2021-12-15 22:56:32', '', '2021-12-16 00:18:09');
INSERT INTO `gen_table_column` VALUES (109, '7', 'tenant_name', '租户名称', 'varchar(30)', 'String', 'tenantName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 6, 'admin', '2021-12-15 22:56:32', '', '2021-12-16 00:18:09');
INSERT INTO `gen_table_column` VALUES (111, '7', 'is_sys', '是否系统通用（0-否，1-是）', 'tinyint(1)', 'Integer', 'isSys', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', 'iot_yes_no', 7, 'admin', '2021-12-15 22:56:33', '', '2021-12-16 00:18:10');
INSERT INTO `gen_table_column` VALUES (113, '7', 'version', '固件版本', 'float(11,2)', 'BigDecimal', 'version', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 8, 'admin', '2021-12-15 22:56:33', '', '2021-12-16 00:18:10');
INSERT INTO `gen_table_column` VALUES (115, '7', 'file_path', '文件路径', 'varchar(255)', 'String', 'filePath', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 9, 'admin', '2021-12-15 22:56:33', '', '2021-12-16 00:18:10');
INSERT INTO `gen_table_column` VALUES (117, '7', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 10, 'admin', '2021-12-15 22:56:33', '', '2021-12-16 00:18:10');
INSERT INTO `gen_table_column` VALUES (118, '7', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 11, 'admin', '2021-12-15 22:56:34', '', '2021-12-16 00:18:10');
INSERT INTO `gen_table_column` VALUES (119, '7', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, '1', NULL, 'EQ', 'datetime', '', 12, 'admin', '2021-12-15 22:56:34', '', '2021-12-16 00:18:10');
INSERT INTO `gen_table_column` VALUES (121, '7', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 13, 'admin', '2021-12-15 22:56:34', '', '2021-12-16 00:18:10');
INSERT INTO `gen_table_column` VALUES (123, '7', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 14, 'admin', '2021-12-15 22:56:34', '', '2021-12-16 00:18:10');
INSERT INTO `gen_table_column` VALUES (125, '7', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 15, 'admin', '2021-12-15 22:56:34', '', '2021-12-16 00:18:11');
INSERT INTO `gen_table_column` VALUES (129, '9', 'group_id', '分组ID', 'bigint(20)', 'Long', 'groupId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-12-15 22:56:35', '', '2021-12-16 00:31:15');
INSERT INTO `gen_table_column` VALUES (131, '9', 'group_name', '分组名称', 'varchar(64)', 'String', 'groupName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2021-12-15 22:56:35', '', '2021-12-16 00:31:15');
INSERT INTO `gen_table_column` VALUES (133, '9', 'group_order', '分组排序', 'tinyint(11)', 'Long', 'groupOrder', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 3, 'admin', '2021-12-15 22:56:35', '', '2021-12-16 00:31:16');
INSERT INTO `gen_table_column` VALUES (135, '9', 'user_id', '用户ID', 'bigint(20)', 'Long', 'userId', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 4, 'admin', '2021-12-15 22:56:35', '', '2021-12-16 00:31:16');
INSERT INTO `gen_table_column` VALUES (137, '9', 'user_name', '用户昵称', 'varchar(30)', 'String', 'userName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 5, 'admin', '2021-12-15 22:56:35', '', '2021-12-16 00:31:16');
INSERT INTO `gen_table_column` VALUES (143, '9', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 8, 'admin', '2021-12-15 22:56:36', '', '2021-12-16 00:31:17');
INSERT INTO `gen_table_column` VALUES (145, '9', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2021-12-15 22:56:36', '', '2021-12-16 00:31:17');
INSERT INTO `gen_table_column` VALUES (147, '9', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, '1', NULL, 'EQ', 'datetime', '', 10, 'admin', '2021-12-15 22:56:36', '', '2021-12-16 00:31:17');
INSERT INTO `gen_table_column` VALUES (149, '9', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 11, 'admin', '2021-12-15 22:56:36', '', '2021-12-16 00:31:17');
INSERT INTO `gen_table_column` VALUES (152, '9', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 12, 'admin', '2021-12-15 22:56:37', '', '2021-12-16 00:31:18');
INSERT INTO `gen_table_column` VALUES (154, '9', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 13, 'admin', '2021-12-15 22:56:37', '', '2021-12-16 00:31:18');
INSERT INTO `gen_table_column` VALUES (155, '11', 'product_id', '产品ID', 'bigint(20)', 'Long', 'productId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-12-15 22:56:37', '', '2021-12-16 00:22:12');
INSERT INTO `gen_table_column` VALUES (158, '11', 'product_name', '产品名称', 'varchar(64)', 'String', 'productName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2021-12-15 22:56:37', '', '2021-12-16 00:22:12');
INSERT INTO `gen_table_column` VALUES (160, '11', 'category_id', '产品分类ID', 'bigint(20)', 'Long', 'categoryId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2021-12-15 22:56:38', '', '2021-12-16 00:22:12');
INSERT INTO `gen_table_column` VALUES (162, '11', 'category_name', '产品分类名称', 'varchar(64)', 'String', 'categoryName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 4, 'admin', '2021-12-15 22:56:38', '', '2021-12-16 00:22:12');
INSERT INTO `gen_table_column` VALUES (164, '11', 'tenant_id', '租户ID', 'bigint(20)', 'Long', 'tenantId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2021-12-15 22:56:38', '', '2021-12-16 00:22:12');
INSERT INTO `gen_table_column` VALUES (166, '11', 'tenant_name', '租户名称', 'varchar(30)', 'String', 'tenantName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 6, 'admin', '2021-12-15 22:56:38', '', '2021-12-16 00:22:12');
INSERT INTO `gen_table_column` VALUES (168, '11', 'is_sys', '是否系统通用（0-否，1-是）', 'tinyint(1)', 'Integer', 'isSys', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2021-12-15 22:56:38', '', '2021-12-16 00:22:12');
INSERT INTO `gen_table_column` VALUES (169, '11', 'status', '状态（1-未发布，2-已发布，不能修改）', 'tinyint(1)', 'Integer', 'status', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', 'iot_yes_no', 8, 'admin', '2021-12-15 22:56:38', '', '2021-12-16 00:22:13');
INSERT INTO `gen_table_column` VALUES (173, '11', 'device_type', '设备类型（1-直连设备、2-网关子设备、3-网关设备）', 'tinyint(1)', 'Integer', 'deviceType', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', '', 10, 'admin', '2021-12-15 22:56:39', '', '2021-12-16 00:22:13');
INSERT INTO `gen_table_column` VALUES (176, '11', 'network_method', '联网方式（1-wifi、2-蓝牙、3-wifi+蓝牙）', 'tinyint(1)', 'Integer', 'networkMethod', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', 'iot_yes_no', 11, 'admin', '2021-12-15 22:56:39', '', '2021-12-16 00:22:13');
INSERT INTO `gen_table_column` VALUES (177, '11', 'vertificate_method', '认证方式（1-账号密码、2-证书、3-Http）', 'tinyint(1)', 'Integer', 'vertificateMethod', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 12, 'admin', '2021-12-15 22:56:39', '', '2021-12-16 00:22:13');
INSERT INTO `gen_table_column` VALUES (179, '11', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 13, 'admin', '2021-12-15 22:56:39', '', '2021-12-16 00:22:13');
INSERT INTO `gen_table_column` VALUES (181, '11', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 14, 'admin', '2021-12-15 22:56:39', '', '2021-12-16 00:22:13');
INSERT INTO `gen_table_column` VALUES (183, '11', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, '1', NULL, 'EQ', 'datetime', '', 15, 'admin', '2021-12-15 22:56:40', '', '2021-12-16 00:22:14');
INSERT INTO `gen_table_column` VALUES (184, '11', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 16, 'admin', '2021-12-15 22:56:40', '', '2021-12-16 00:22:14');
INSERT INTO `gen_table_column` VALUES (186, '11', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 17, 'admin', '2021-12-15 22:56:40', '', '2021-12-16 00:22:14');
INSERT INTO `gen_table_column` VALUES (188, '11', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 18, 'admin', '2021-12-15 22:56:40', '', '2021-12-16 00:22:14');
INSERT INTO `gen_table_column` VALUES (191, '13', 'model_id', '物模型ID', 'bigint(20)', 'Long', 'modelId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-12-15 22:56:40', '', '2021-12-16 00:29:39');
INSERT INTO `gen_table_column` VALUES (193, '13', 'model_name', '物模型名称', 'varchar(64)', 'String', 'modelName', '0', '0', '1', '1', '1', '1', NULL, 'LIKE', 'input', '', 2, 'admin', '2021-12-15 22:56:41', '', '2021-12-16 00:29:39');
INSERT INTO `gen_table_column` VALUES (195, '13', 'product_id', '产品ID', 'bigint(20)', 'Long', 'productId', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 3, 'admin', '2021-12-15 22:56:41', '', '2021-12-16 00:29:39');
INSERT INTO `gen_table_column` VALUES (197, '13', 'product_name', '产品名称', 'varchar(64)', 'String', 'productName', '0', '0', '1', '1', '1', '1', NULL, 'LIKE', 'input', '', 4, 'admin', '2021-12-15 22:56:41', '', '2021-12-16 00:29:39');
INSERT INTO `gen_table_column` VALUES (199, '13', 'tenant_id', '租户ID', 'bigint(20)', 'Long', 'tenantId', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 5, 'admin', '2021-12-15 22:56:41', '', '2021-12-16 00:29:40');
INSERT INTO `gen_table_column` VALUES (201, '13', 'tenant_name', '租户名称', 'varchar(30)', 'String', 'tenantName', '0', '0', '1', '1', '1', '1', NULL, 'LIKE', 'input', '', 6, 'admin', '2021-12-15 22:56:41', '', '2021-12-16 00:29:40');
INSERT INTO `gen_table_column` VALUES (203, '13', 'identifier', '标识符，产品下唯一', 'varchar(32)', 'String', 'identifier', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 7, 'admin', '2021-12-15 22:56:41', '', '2021-12-16 00:29:40');
INSERT INTO `gen_table_column` VALUES (205, '13', 'type', '模型类别（1-属性，2-功能，3-事件）', 'tinyint(1)', 'Integer', 'type', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'select', 'iot_things_type', 8, 'admin', '2021-12-15 22:56:42', '', '2021-12-16 00:29:40');
INSERT INTO `gen_table_column` VALUES (207, '13', 'datatype', '数据类型（integer、decimal、string、bool、array、enum）', 'varchar(64)', 'String', 'datatype', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'select', 'iot_data_type', 9, 'admin', '2021-12-15 22:56:42', '', '2021-12-16 00:29:40');
INSERT INTO `gen_table_column` VALUES (209, '13', 'specs', '数据定义', 'json', 'String', 'specs', '0', '0', '1', '1', '1', '1', NULL, 'EQ', NULL, '', 10, 'admin', '2021-12-15 22:56:42', '', '2021-12-16 00:29:40');
INSERT INTO `gen_table_column` VALUES (211, '13', 'is_Top', '是否首页显示（0-否，1-是）', 'tinyint(1)', 'Integer', 'isTop', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', 'iot_yes_no', 11, 'admin', '2021-12-15 22:56:42', '', '2021-12-16 00:29:41');
INSERT INTO `gen_table_column` VALUES (213, '13', 'is_Monitor', '是否实时监测（0-否，1-是）', 'tinyint(1)', 'Integer', 'isMonitor', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', 'iot_yes_no', 12, 'admin', '2021-12-15 22:56:42', '', '2021-12-16 00:29:41');
INSERT INTO `gen_table_column` VALUES (214, '13', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 13, 'admin', '2021-12-15 22:56:42', '', '2021-12-16 00:29:41');
INSERT INTO `gen_table_column` VALUES (215, '13', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 14, 'admin', '2021-12-15 22:56:43', '', '2021-12-16 00:29:41');
INSERT INTO `gen_table_column` VALUES (217, '13', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, '1', NULL, 'EQ', 'datetime', '', 15, 'admin', '2021-12-15 22:56:43', '', '2021-12-16 00:29:41');
INSERT INTO `gen_table_column` VALUES (220, '13', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 16, 'admin', '2021-12-15 22:56:43', '', '2021-12-16 00:29:41');
INSERT INTO `gen_table_column` VALUES (222, '13', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 17, 'admin', '2021-12-15 22:56:43', '', '2021-12-16 00:29:42');
INSERT INTO `gen_table_column` VALUES (224, '13', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 18, 'admin', '2021-12-15 22:56:43', '', '2021-12-16 00:29:42');
INSERT INTO `gen_table_column` VALUES (227, '15', 'template_id', '物模型ID', 'bigint(20)', 'Long', 'templateId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-12-15 22:56:44', '', '2021-12-16 00:26:56');
INSERT INTO `gen_table_column` VALUES (229, '15', 'template_name', '物模型名称', 'varchar(64)', 'String', 'templateName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2021-12-15 22:56:44', '', '2021-12-16 00:26:57');
INSERT INTO `gen_table_column` VALUES (235, '15', 'tenant_id', '租户ID', 'bigint(20)', 'Long', 'tenantId', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 5, 'admin', '2021-12-15 22:56:44', '', '2021-12-16 00:26:57');
INSERT INTO `gen_table_column` VALUES (237, '15', 'tenant_name', '租户名称', 'varchar(30)', 'String', 'tenantName', '0', '0', '1', '1', '1', '1', NULL, 'LIKE', 'input', '', 6, 'admin', '2021-12-15 22:56:45', '', '2021-12-16 00:26:57');
INSERT INTO `gen_table_column` VALUES (239, '15', 'identifier', '标识符，产品下唯一', 'varchar(32)', 'String', 'identifier', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 7, 'admin', '2021-12-15 22:56:45', '', '2021-12-16 00:26:58');
INSERT INTO `gen_table_column` VALUES (240, '15', 'type', '模型类别（1-属性，2-功能，3-事件）', 'tinyint(1)', 'Integer', 'type', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'iot_things_type', 8, 'admin', '2021-12-15 22:56:45', '', '2021-12-16 00:26:58');
INSERT INTO `gen_table_column` VALUES (241, '15', 'datatype', '数据类型（integer、decimal、string、bool、array、enum）', 'varchar(64)', 'String', 'datatype', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'select', 'iot_data_type', 9, 'admin', '2021-12-15 22:56:45', '', '2021-12-16 00:26:58');
INSERT INTO `gen_table_column` VALUES (243, '15', 'specs', '数据定义', 'json', 'String', 'specs', '0', '0', '1', '1', '1', '1', '1', 'EQ', NULL, '', 10, 'admin', '2021-12-15 22:56:45', '', '2021-12-16 00:26:58');
INSERT INTO `gen_table_column` VALUES (245, '15', 'is_sys', '是否系统通用（0-否，1-是）', 'tinyint(1)', 'Integer', 'isSys', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 11, 'admin', '2021-12-15 22:56:45', '', '2021-12-16 00:26:59');
INSERT INTO `gen_table_column` VALUES (247, '15', 'is_Top', '是否首页显示（0-否，1-是）', 'tinyint(1)', 'Integer', 'isTop', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 12, 'admin', '2021-12-15 22:56:46', '', '2021-12-16 00:26:59');
INSERT INTO `gen_table_column` VALUES (249, '15', 'is_Monitor', '是否实时监测（0-否，1-是）', 'tinyint(1)', 'Integer', 'isMonitor', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 13, 'admin', '2021-12-15 22:56:46', '', '2021-12-16 00:26:59');
INSERT INTO `gen_table_column` VALUES (251, '15', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 14, 'admin', '2021-12-15 22:56:46', '', '2021-12-16 00:26:59');
INSERT INTO `gen_table_column` VALUES (253, '15', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 15, 'admin', '2021-12-15 22:56:46', '', '2021-12-16 00:26:59');
INSERT INTO `gen_table_column` VALUES (255, '15', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, '1', NULL, 'EQ', 'datetime', '', 16, 'admin', '2021-12-15 22:56:46', '', '2021-12-16 00:26:59');
INSERT INTO `gen_table_column` VALUES (257, '15', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 17, 'admin', '2021-12-15 22:56:46', '', '2021-12-16 00:26:59');
INSERT INTO `gen_table_column` VALUES (259, '15', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 18, 'admin', '2021-12-15 22:56:47', '', '2021-12-16 00:27:00');
INSERT INTO `gen_table_column` VALUES (261, '15', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 19, 'admin', '2021-12-15 22:56:47', '', '2021-12-16 00:27:00');
INSERT INTO `gen_table_column` VALUES (309, '20', 'alert_id', '告警ID', 'bigint(20)', 'Long', 'alertId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-01-13 14:53:24', '', '2022-01-13 15:16:02');
INSERT INTO `gen_table_column` VALUES (310, '20', 'alert_name', '告警名称', 'varchar(64)', 'String', 'alertName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2022-01-13 14:53:24', '', '2022-01-13 15:16:02');
INSERT INTO `gen_table_column` VALUES (311, '20', 'alert_level', '告警级别（1=提醒通知，2=轻微问题，3=严重警告）', 'tinyint(11)', 'Long', 'alertLevel', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'iot_alert_level', 3, 'admin', '2022-01-13 14:53:24', '', '2022-01-13 15:16:02');
INSERT INTO `gen_table_column` VALUES (312, '20', 'product_id', '产品ID', 'bigint(20)', 'Long', 'productId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2022-01-13 14:53:25', '', '2022-01-13 15:16:03');
INSERT INTO `gen_table_column` VALUES (313, '20', 'product_name', '产品名称', 'varchar(64)', 'String', 'productName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 5, 'admin', '2022-01-13 14:53:25', '', '2022-01-13 15:16:03');
INSERT INTO `gen_table_column` VALUES (314, '20', 'triggers', '触发器', 'json', 'String', 'triggers', '0', '0', '1', '1', '1', '1', NULL, 'EQ', NULL, '', 6, 'admin', '2022-01-13 14:53:25', '', '2022-01-13 15:16:03');
INSERT INTO `gen_table_column` VALUES (315, '20', 'actions', '执行动作', 'json', 'String', 'actions', '0', '0', '1', '1', '1', '1', NULL, 'EQ', NULL, '', 7, 'admin', '2022-01-13 14:53:25', '', '2022-01-13 15:16:03');
INSERT INTO `gen_table_column` VALUES (316, '20', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 8, 'admin', '2022-01-13 14:53:26', '', '2022-01-13 15:16:03');
INSERT INTO `gen_table_column` VALUES (317, '20', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, '1', NULL, 'EQ', 'datetime', '', 9, 'admin', '2022-01-13 14:53:26', '', '2022-01-13 15:16:04');
INSERT INTO `gen_table_column` VALUES (318, '20', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 10, 'admin', '2022-01-13 14:53:26', '', '2022-01-13 15:16:04');
INSERT INTO `gen_table_column` VALUES (319, '20', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 11, 'admin', '2022-01-13 14:53:26', '', '2022-01-13 15:16:04');
INSERT INTO `gen_table_column` VALUES (320, '20', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 12, 'admin', '2022-01-13 14:53:26', '', '2022-01-13 15:16:04');
INSERT INTO `gen_table_column` VALUES (321, '21', 'alert_log__id', '告警ID', 'bigint(20)', 'Long', 'alertLogId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-01-13 14:53:27', '', '2022-01-13 15:16:32');
INSERT INTO `gen_table_column` VALUES (323, '21', 'alert_level', '告警级别（1=提醒通知，2=轻微问题，3=严重警告，4=场景联动）', 'tinyint(11)', 'Long', 'alertLevel', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'iot_alert_level', 3, 'admin', '2022-01-13 14:53:27', '', '2022-01-13 15:16:33');
INSERT INTO `gen_table_column` VALUES (324, '21', 'status', '处理状态(0=不需要处理,1=未处理,2=已处理)', 'tinyint(11)', 'Long', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'iot_process_status', 4, 'admin', '2022-01-13 14:53:28', '', '2022-01-13 15:16:33');
INSERT INTO `gen_table_column` VALUES (325, '21', 'product_id', '产品ID', 'bigint(20)', 'Long', 'productId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2022-01-13 14:53:28', '', '2022-01-13 15:16:33');
INSERT INTO `gen_table_column` VALUES (326, '21', 'product_name', '产品名称', 'varchar(64)', 'String', 'productName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 6, 'admin', '2022-01-13 14:53:28', '', '2022-01-13 15:16:33');
INSERT INTO `gen_table_column` VALUES (327, '21', 'device_id', '设备ID', 'bigint(20)', 'Long', 'deviceId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2022-01-13 14:53:28', '', '2022-01-13 15:16:33');
INSERT INTO `gen_table_column` VALUES (328, '21', 'device_name', '设备名称', 'varchar(64)', 'String', 'deviceName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 8, 'admin', '2022-01-13 14:53:28', '', '2022-01-13 15:16:34');
INSERT INTO `gen_table_column` VALUES (329, '21', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2022-01-13 14:53:29', '', '2022-01-13 15:16:34');
INSERT INTO `gen_table_column` VALUES (330, '21', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, '1', NULL, 'EQ', 'datetime', '', 10, 'admin', '2022-01-13 14:53:29', '', '2022-01-13 15:16:34');
INSERT INTO `gen_table_column` VALUES (331, '21', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 11, 'admin', '2022-01-13 14:53:29', '', '2022-01-13 15:16:34');
INSERT INTO `gen_table_column` VALUES (332, '21', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 12, 'admin', '2022-01-13 14:53:29', '', '2022-01-13 15:16:34');
INSERT INTO `gen_table_column` VALUES (333, '21', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 13, 'admin', '2022-01-13 14:53:29', '', '2022-01-13 15:16:35');
INSERT INTO `gen_table_column` VALUES (334, '22', 'log_id', '设备日志ID', 'bigint(20)', 'Long', 'logId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-01-13 14:53:30', '', '2022-01-13 15:17:15');
INSERT INTO `gen_table_column` VALUES (335, '22', 'log_name', '日志名称', 'varchar(64)', 'String', 'logName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2022-01-13 14:53:30', '', '2022-01-13 15:17:15');
INSERT INTO `gen_table_column` VALUES (336, '22', 'log_type', '类型（1=属性上报，2=事件上报，3=调用功能，4=设备升级，5=设备上线，6=设备离线）', 'tinyint(1)', 'Integer', 'logType', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'iot_device_log_type', 3, 'admin', '2022-01-13 14:53:30', '', '2022-01-13 15:17:15');
INSERT INTO `gen_table_column` VALUES (337, '22', 'log_value', '日志值', 'varchar(64)', 'String', 'logValue', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2022-01-13 14:53:31', '', '2022-01-13 15:17:16');
INSERT INTO `gen_table_column` VALUES (338, '22', 'device_id', '设备ID', 'bigint(20)', 'Long', 'deviceId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2022-01-13 14:53:31', '', '2022-01-13 15:17:16');
INSERT INTO `gen_table_column` VALUES (339, '22', 'device_name', '设备名称', 'varchar(64)', 'String', 'deviceName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 6, 'admin', '2022-01-13 14:53:31', '', '2022-01-13 15:17:16');
INSERT INTO `gen_table_column` VALUES (340, '22', 'identity', '标识符', 'varchar(64)', 'String', 'identity', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 7, 'admin', '2022-01-13 14:53:31', '', '2022-01-13 15:17:16');
INSERT INTO `gen_table_column` VALUES (341, '22', 'datatype', '数据类型', 'varchar(32)', 'String', 'datatype', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'select', '', 8, 'admin', '2022-01-13 14:53:32', '', '2022-01-13 15:17:16');
INSERT INTO `gen_table_column` VALUES (342, '22', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2022-01-13 14:53:32', '', '2022-01-13 15:17:17');
INSERT INTO `gen_table_column` VALUES (343, '22', 'is_monitor', '是否监测数据（1=是，0=否）', 'tinyint(1)', 'Integer', 'isMonitor', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 10, 'admin', '2022-01-13 14:53:32', '', '2022-01-13 15:17:17');
INSERT INTO `gen_table_column` VALUES (344, '22', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, '1', NULL, 'EQ', 'datetime', '', 11, 'admin', '2022-01-13 14:53:32', '', '2022-01-13 15:17:17');
INSERT INTO `gen_table_column` VALUES (345, '22', 'remark', '备注', 'varchar(200)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 12, 'admin', '2022-01-13 14:53:32', '', '2022-01-13 15:17:17');
INSERT INTO `gen_table_column` VALUES (346, '23', 'scene_id', '场景ID', 'bigint(20)', 'Long', 'sceneId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-01-13 14:53:33', '', '2022-01-13 15:17:38');
INSERT INTO `gen_table_column` VALUES (347, '23', 'scene_name', '场景名称', 'varchar(64)', 'String', 'sceneName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2022-01-13 14:53:33', '', '2022-01-13 15:17:38');
INSERT INTO `gen_table_column` VALUES (348, '23', 'user_id', '用户ID', 'bigint(20)', 'Long', 'userId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2022-01-13 14:53:33', '', '2022-01-13 15:17:38');
INSERT INTO `gen_table_column` VALUES (349, '23', 'user_name', '用户名称', 'varchar(64)', 'String', 'userName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 4, 'admin', '2022-01-13 14:53:34', '', '2022-01-13 15:17:38');
INSERT INTO `gen_table_column` VALUES (350, '23', 'triggers', '触发器', 'json', 'String', 'triggers', '0', '0', '1', '1', '1', '1', NULL, 'EQ', NULL, '', 5, 'admin', '2022-01-13 14:53:34', '', '2022-01-13 15:17:38');
INSERT INTO `gen_table_column` VALUES (351, '23', 'actions', '执行动作', 'json', 'String', 'actions', '0', '0', '1', '1', '1', '1', NULL, 'EQ', NULL, '', 6, 'admin', '2022-01-13 14:53:34', '', '2022-01-13 15:17:39');
INSERT INTO `gen_table_column` VALUES (352, '23', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 7, 'admin', '2022-01-13 14:53:34', '', '2022-01-13 15:17:39');
INSERT INTO `gen_table_column` VALUES (353, '23', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, '1', NULL, 'EQ', 'datetime', '', 8, 'admin', '2022-01-13 14:53:34', '', '2022-01-13 15:17:39');
INSERT INTO `gen_table_column` VALUES (354, '23', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2022-01-13 14:53:35', '', '2022-01-13 15:17:39');
INSERT INTO `gen_table_column` VALUES (355, '23', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 10, 'admin', '2022-01-13 14:53:35', '', '2022-01-13 15:17:39');
INSERT INTO `gen_table_column` VALUES (356, '23', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 11, 'admin', '2022-01-13 14:53:35', '', '2022-01-13 15:17:40');
INSERT INTO `gen_table_column` VALUES (374, '25', 'job_id', '任务ID', 'bigint(20)', 'Long', 'jobId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-01-17 16:18:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (375, '25', 'job_name', '任务名称', 'varchar(64)', 'String', 'jobName', '1', '0', NULL, '1', NULL, NULL, NULL, 'LIKE', 'input', '', 2, 'admin', '2022-01-17 16:18:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (376, '25', 'job_group', '任务组名', 'varchar(64)', 'String', 'jobGroup', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 3, 'admin', '2022-01-17 16:18:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (378, '25', 'cron_expression', 'cron执行表达式', 'varchar(255)', 'String', 'cronExpression', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2022-01-17 16:18:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (379, '25', 'misfire_policy', '计划执行错误策略（1立即执行 2执行一次 3放弃执行）', 'varchar(20)', 'String', 'misfirePolicy', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2022-01-17 16:18:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (380, '25', 'concurrent', '是否并发执行（0允许 1禁止）', 'char(1)', 'String', 'concurrent', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2022-01-17 16:18:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (381, '25', 'status', '状态（0正常 1暂停）', 'char(1)', 'String', 'status', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', '', 8, 'admin', '2022-01-17 16:18:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (382, '25', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2022-01-17 16:18:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (383, '25', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 10, 'admin', '2022-01-17 16:18:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (384, '25', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 11, 'admin', '2022-01-17 16:18:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (385, '25', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 12, 'admin', '2022-01-17 16:18:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (386, '25', 'remark', '备注信息', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 13, 'admin', '2022-01-17 16:18:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (387, '25', 'device_id', '设备ID', 'bigint(11)', 'Long', 'deviceId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 14, 'admin', '2022-01-17 16:18:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (388, '25', 'device_name', '设备名称', 'varchar(64)', 'String', 'deviceName', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 15, 'admin', '2022-01-17 16:18:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (389, '25', 'is_advance', '是否详细corn表达式（1=是，0=否）', 'tinyint(1)', 'Integer', 'isAdvance', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 16, 'admin', '2022-01-17 16:18:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (390, '25', 'actions', '执行的动作集合', 'json', 'String', 'actions', '0', '0', NULL, '1', '1', '1', '1', 'EQ', NULL, '', 17, 'admin', '2022-01-17 16:18:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (391, '26', 'device_id', '设备ID', 'bigint(20)', 'Long', 'deviceId', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-01-24 00:29:24', '', NULL);
INSERT INTO `gen_table_column` VALUES (392, '26', 'group_id', '分组ID', 'bigint(20)', 'Long', 'groupId', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 2, 'admin', '2022-01-24 00:29:24', '', NULL);
INSERT INTO `gen_table_column` VALUES (393, '25', 'is_repeat', '是否重复（0=否，1=是）', 'tinyint(11)', 'Long', 'isRepeat', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 17, '', '2022-01-24 00:30:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (394, '25', 'job_type', '定时类型（1=设备定时，2=设备告警，3=场景联动）', 'tinyint(11)', 'Long', 'jobType', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', '', 18, '', '2022-01-24 00:30:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (395, '25', 'product_id', '产品ID', 'bigint(20)', 'Long', 'productId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 19, '', '2022-01-24 00:30:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (396, '25', 'product_name', '产品名称', 'varchar(64)', 'String', 'productName', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 20, '', '2022-01-24 00:30:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (397, '25', 'scene_id', '场景联动ID', 'bigint(20)', 'Long', 'sceneId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 21, '', '2022-01-24 00:30:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (398, '25', 'alert_id', '告警ID', 'bigint(20)', 'Long', 'alertId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 22, '', '2022-01-24 00:31:00', '', NULL);
INSERT INTO `gen_table_column` VALUES (399, '2', 'is_shadow', '是否启用设备影子(0=禁用，1=启用)', 'tinyint(1)', 'Integer', 'isShadow', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 13, '', '2022-01-27 15:39:45', '', NULL);
INSERT INTO `gen_table_column` VALUES (400, '2', 'is_customer_location', '是否自定义位置（0=否，1=是）', 'tinyint(1)', 'Integer', 'isCustomerLocation', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 14, '', '2022-01-27 15:39:45', '', NULL);
INSERT INTO `gen_table_column` VALUES (401, '2', 'things_model_value', '物模型值', 'json', 'String', 'thingsModelValue', '0', '0', NULL, '1', '1', '1', '1', 'EQ', NULL, '', 15, '', '2022-01-27 15:39:45', '', NULL);
INSERT INTO `gen_table_column` VALUES (402, '2', 'img_url', '图片地址', 'varchar(255)', 'String', 'imgUrl', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 21, '', '2022-01-27 15:39:45', '', NULL);
INSERT INTO `gen_table_column` VALUES (403, '5', 'phonenumber', '手机号码', 'varchar(11)', 'String', 'phonenumber', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 6, '', '2022-01-27 15:39:52', '', NULL);
INSERT INTO `gen_table_column` VALUES (404, '11', 'mqtt_account', 'mqtt账号', 'varchar(64)', 'String', 'mqttAccount', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 8, '', '2022-01-27 15:40:00', '', NULL);
INSERT INTO `gen_table_column` VALUES (405, '11', 'mqtt_password', 'mqtt密码', 'varchar(64)', 'String', 'mqttPassword', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 9, '', '2022-01-27 15:40:00', '', NULL);
INSERT INTO `gen_table_column` VALUES (406, '11', 'things_models_json', '物模型JSON（属性、功能、事件）', 'json', 'String', 'thingsModelsJson', '0', '0', NULL, '1', '1', '1', '1', 'EQ', NULL, '', 11, '', '2022-01-27 15:40:00', '', NULL);
INSERT INTO `gen_table_column` VALUES (407, '11', 'img_url', '图片地址', 'varchar(255)', 'String', 'imgUrl', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 15, '', '2022-01-27 15:40:00', '', NULL);
INSERT INTO `gen_table_column` VALUES (408, '20', 'status', '告警状态（1-启动，2-停止）', 'tinyint(1)', 'Integer', 'status', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', '', 8, '', '2022-01-27 15:40:08', '', NULL);
INSERT INTO `gen_table_column` VALUES (409, '21', 'alert_name', '告警名称', 'varchar(64)', 'String', 'alertName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, '', '2022-01-27 15:40:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (410, '21', 'user_id', '用户ID', 'bigint(20)', 'Long', 'userId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 9, '', '2022-01-27 15:40:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (411, '21', 'user_name', '用户昵称', 'varchar(30)', 'String', 'userName', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 10, '', '2022-01-27 15:40:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (412, '21', 'type', '类型（1=告警，2=场景联动）', 'tinyint(11)', 'Long', 'type', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', '', 16, '', '2022-01-27 15:40:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (413, '27', 'client_id', '客户端ID', 'varchar(255)', 'String', 'clientId', '1', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 1, 'admin', '2022-02-07 20:24:16', '', '2022-02-07 20:38:11');
INSERT INTO `gen_table_column` VALUES (414, '27', 'resource_ids', '资源', 'varchar(255)', 'String', 'resourceIds', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 2, 'admin', '2022-02-07 20:24:16', '', '2022-02-07 20:38:11');
INSERT INTO `gen_table_column` VALUES (415, '27', 'client_secret', '客户端秘钥', 'varchar(255)', 'String', 'clientSecret', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 3, 'admin', '2022-02-07 20:24:16', '', '2022-02-07 20:38:11');
INSERT INTO `gen_table_column` VALUES (416, '27', 'scope', '权限范围', 'varchar(255)', 'String', 'scope', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'select', '', 4, 'admin', '2022-02-07 20:24:16', '', '2022-02-07 20:38:11');
INSERT INTO `gen_table_column` VALUES (417, '27', 'authorized_grant_types', '授权模式', 'varchar(255)', 'String', 'authorizedGrantTypes', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', '', 5, 'admin', '2022-02-07 20:24:16', '', '2022-02-07 20:38:11');
INSERT INTO `gen_table_column` VALUES (418, '27', 'web_server_redirect_uri', '回调地址', 'varchar(255)', 'String', 'webServerRedirectUri', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 6, 'admin', '2022-02-07 20:24:16', '', '2022-02-07 20:38:11');
INSERT INTO `gen_table_column` VALUES (419, '27', 'authorities', '权限', 'varchar(255)', 'String', 'authorities', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 7, 'admin', '2022-02-07 20:24:16', '', '2022-02-07 20:38:11');
INSERT INTO `gen_table_column` VALUES (420, '27', 'access_token_validity', 'access token有效时间', 'int(11)', 'Long', 'accessTokenValidity', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 8, 'admin', '2022-02-07 20:24:16', '', '2022-02-07 20:38:11');
INSERT INTO `gen_table_column` VALUES (421, '27', 'refresh_token_validity', 'refresh token有效时间', 'int(11)', 'Long', 'refreshTokenValidity', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 9, 'admin', '2022-02-07 20:24:16', '', '2022-02-07 20:38:11');
INSERT INTO `gen_table_column` VALUES (422, '27', 'additional_information', '预留的字段', 'text', 'String', 'additionalInformation', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 10, 'admin', '2022-02-07 20:24:16', '', '2022-02-07 20:38:11');
INSERT INTO `gen_table_column` VALUES (423, '27', 'autoapprove', '自动授权', 'varchar(255)', 'String', 'autoapprove', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', '', 11, 'admin', '2022-02-07 20:24:16', '', '2022-02-07 20:38:11');
INSERT INTO `gen_table_column` VALUES (424, '27', 'type', '平台', 'tinyint(1)', 'Integer', 'type', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', 'oauth_platform', 12, 'admin', '2022-02-07 20:24:16', '', '2022-02-07 20:38:11');
INSERT INTO `gen_table_column` VALUES (476, '33', 'news_id', '新闻ID', 'bigint(20)', 'Long', 'newsId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-04-09 19:15:19', '', '2022-04-09 19:20:56');
INSERT INTO `gen_table_column` VALUES (477, '33', 'title', '标题', 'varchar(64)', 'String', 'title', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2022-04-09 19:15:20', '', '2022-04-09 19:20:56');
INSERT INTO `gen_table_column` VALUES (478, '33', 'content', '内容', 'text', 'String', 'content', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'editor', '', 3, 'admin', '2022-04-09 19:15:20', '', '2022-04-09 19:20:56');
INSERT INTO `gen_table_column` VALUES (479, '33', 'img_url', '图片', 'varchar(128)', 'String', 'imgUrl', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'imageUpload', '', 4, 'admin', '2022-04-09 19:15:20', '', '2022-04-09 19:20:56');
INSERT INTO `gen_table_column` VALUES (480, '33', 'is_top', '置顶', 'tinyint(1)', 'Integer', 'isTop', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'sys_yes_no', 5, 'admin', '2022-04-09 19:15:20', '', '2022-04-09 19:20:57');
INSERT INTO `gen_table_column` VALUES (481, '33', 'is_banner', '广告', 'tinyint(1)', 'Integer', 'isBanner', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'sys_yes_no', 6, 'admin', '2022-04-09 19:15:20', '', '2022-04-09 19:20:57');
INSERT INTO `gen_table_column` VALUES (482, '33', 'category_id', '分类ID', 'bigint(20)', 'Long', 'categoryId', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 7, 'admin', '2022-04-09 19:15:21', '', '2022-04-09 19:20:57');
INSERT INTO `gen_table_column` VALUES (483, '33', 'catgory_name', '分类名称', 'varchar(32)', 'String', 'catgoryName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 8, 'admin', '2022-04-09 19:15:21', '', '2022-04-09 19:20:57');
INSERT INTO `gen_table_column` VALUES (484, '33', 'status', '发布', 'tinyint(1)', 'Integer', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'sys_yes_no', 9, 'admin', '2022-04-09 19:15:21', '', '2022-04-09 19:20:57');
INSERT INTO `gen_table_column` VALUES (485, '33', 'author', '作者', 'varchar(50)', 'String', 'author', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 10, 'admin', '2022-04-09 19:15:21', '', '2022-04-09 19:20:58');
INSERT INTO `gen_table_column` VALUES (486, '33', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 11, 'admin', '2022-04-09 19:15:21', '', '2022-04-09 19:20:58');
INSERT INTO `gen_table_column` VALUES (487, '33', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 12, 'admin', '2022-04-09 19:15:22', '', '2022-04-09 19:20:58');
INSERT INTO `gen_table_column` VALUES (488, '33', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, '1', NULL, 'EQ', 'datetime', '', 13, 'admin', '2022-04-09 19:15:22', '', '2022-04-09 19:20:58');
INSERT INTO `gen_table_column` VALUES (489, '33', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 14, 'admin', '2022-04-09 19:15:22', '', '2022-04-09 19:20:58');
INSERT INTO `gen_table_column` VALUES (490, '33', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 15, 'admin', '2022-04-09 19:15:22', '', '2022-04-09 19:20:59');
INSERT INTO `gen_table_column` VALUES (491, '33', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 16, 'admin', '2022-04-09 19:15:22', '', '2022-04-09 19:20:59');
INSERT INTO `gen_table_column` VALUES (492, '34', 'category_id', '分类ID', 'bigint(20)', 'Long', 'categoryId', '1', '1', NULL, '1', NULL, '1', NULL, 'EQ', 'input', '', 1, 'admin', '2022-04-09 19:15:23', '', '2022-04-09 19:23:45');
INSERT INTO `gen_table_column` VALUES (493, '34', 'category_name', '分类名字', 'varchar(64)', 'String', 'categoryName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2022-04-09 19:15:23', '', '2022-04-09 19:23:45');
INSERT INTO `gen_table_column` VALUES (494, '34', 'order_num', '显示顺序', 'int(2)', 'Integer', 'orderNum', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 3, 'admin', '2022-04-09 19:15:23', '', '2022-04-09 19:23:45');
INSERT INTO `gen_table_column` VALUES (495, '34', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 4, 'admin', '2022-04-09 19:15:23', '', '2022-04-09 19:23:45');
INSERT INTO `gen_table_column` VALUES (496, '34', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 5, 'admin', '2022-04-09 19:15:24', '', '2022-04-09 19:23:46');
INSERT INTO `gen_table_column` VALUES (497, '34', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, '1', NULL, 'EQ', 'datetime', '', 6, 'admin', '2022-04-09 19:15:24', '', '2022-04-09 19:23:46');
INSERT INTO `gen_table_column` VALUES (498, '34', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 7, 'admin', '2022-04-09 19:15:24', '', '2022-04-09 19:23:46');
INSERT INTO `gen_table_column` VALUES (499, '34', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 8, 'admin', '2022-04-09 19:15:24', '', '2022-04-09 19:23:46');
INSERT INTO `gen_table_column` VALUES (500, '34', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 9, 'admin', '2022-04-09 19:15:24', '', '2022-04-09 19:23:46');

-- ----------------------------
-- Table structure for iot_alert
-- ----------------------------
DROP TABLE IF EXISTS `iot_alert`;
CREATE TABLE `iot_alert`  (
  `alert_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '告警ID',
  `alert_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '告警名称',
  `alert_level` tinyint(11) NOT NULL COMMENT '告警级别（1=提醒通知，2=轻微问题，3=严重警告）',
  `product_id` bigint(20) NOT NULL COMMENT '产品ID',
  `product_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '产品名称',
  `triggers` json NOT NULL COMMENT '触发器',
  `actions` json NOT NULL COMMENT '执行动作',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '告警状态（1-启动，2-停止）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`alert_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '设备告警' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_alert
-- ----------------------------

-- ----------------------------
-- Table structure for iot_alert_log
-- ----------------------------
DROP TABLE IF EXISTS `iot_alert_log`;
CREATE TABLE `iot_alert_log`  (
  `alert_log__id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '告警ID',
  `alert_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '告警名称',
  `alert_level` tinyint(11) NOT NULL COMMENT '告警级别（1=提醒通知，2=轻微问题，3=严重警告）',
  `status` tinyint(11) NOT NULL COMMENT '处理状态(1=不需要处理,2=未处理,3=已处理)',
  `product_id` bigint(20) NULL DEFAULT NULL COMMENT '产品ID',
  `product_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品名称',
  `device_id` bigint(20) NULL DEFAULT NULL COMMENT '设备ID',
  `device_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备名称',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户ID',
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户昵称',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `type` tinyint(11) NULL DEFAULT NULL COMMENT '类型（1=告警，2=场景联动）',
  PRIMARY KEY (`alert_log__id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '设备告警日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_alert_log
-- ----------------------------

-- ----------------------------
-- Table structure for iot_category
-- ----------------------------
DROP TABLE IF EXISTS `iot_category`;
CREATE TABLE `iot_category`  (
  `category_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '产品分类ID',
  `category_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '产品分类名称',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `tenant_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '租户名称',
  `is_sys` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否系统通用（0-否，1-是）',
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '父级ID',
  `order_num` int(4) NULL DEFAULT NULL COMMENT '显示顺序',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品分类' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_category
-- ----------------------------
INSERT INTO `iot_category` VALUES (1, '电工照明', 1, 'admin', 1, 0, 1, '0', '', '2022-03-01 11:44:37', '', NULL, '例如：通断器、开关、插座、窗帘、灯');
INSERT INTO `iot_category` VALUES (2, '家居安防', 1, 'admin', 1, 0, 2, '0', '', '2021-12-18 14:46:52', '', '2021-12-18 14:49:48', '例如：智能门锁、摄像头、智能窗帘');
INSERT INTO `iot_category` VALUES (3, '环境电器', 1, 'admin', 1, 0, 3, '0', '', '2021-12-18 14:50:24', '', NULL, '例如：加湿器、风扇、扫地机器人');
INSERT INTO `iot_category` VALUES (4, '大家电', 1, 'admin', 1, 0, 4, '0', '', '2021-12-18 14:50:58', '', '2021-12-18 14:52:30', '例如：冰箱、热水器、电视');
INSERT INTO `iot_category` VALUES (5, '厨房电器', 1, 'admin', 1, 0, 5, '0', '', '2021-12-18 14:51:42', '', '2021-12-18 14:52:35', '例如：油烟机、烤箱、电饭煲');
INSERT INTO `iot_category` VALUES (6, '个护健康', 1, 'admin', 1, 0, 6, '0', '', '2021-12-18 14:52:15', '', '2021-12-18 14:52:40', '例如：洗衣机、按摩椅');
INSERT INTO `iot_category` VALUES (7, '其他', 1, 'admin', 1, 0, 7, '0', '', '2021-12-18 14:52:54', '', '2021-12-20 15:04:33', '其他');

-- ----------------------------
-- Table structure for iot_device
-- ----------------------------
DROP TABLE IF EXISTS `iot_device`;
CREATE TABLE `iot_device`  (
  `device_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '设备ID',
  `device_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备名称',
  `product_id` bigint(20) NOT NULL COMMENT '产品ID',
  `product_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '产品名称',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户昵称',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `tenant_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '租户名称',
  `serial_number` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备编号',
  `firmware_version` float(11, 2) NOT NULL COMMENT '固件版本',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '设备状态（1-未激活，2-禁用，3-在线，4-离线）',
  `rssi` tinyint(11) NULL DEFAULT NULL COMMENT '信号强度（\r\n信号极好4格[-55— 0]，\r\n信号好3格[-70— -55]，\r\n信号一般2格[-85— -70]，\r\n信号差1格[-100— -85]）',
  `is_shadow` tinyint(1) NULL DEFAULT NULL COMMENT '是否启用设备影子(0=禁用，1=启用)',
  `is_custom_location` tinyint(1) NULL DEFAULT NULL COMMENT '是否自定义位置（0=否，1=是）',
  `things_model_value` json NULL COMMENT '物模型值',
  `network_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备所在地址',
  `network_ip` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备入网IP',
  `longitude` double(11, 6) NULL DEFAULT NULL COMMENT '设备经度',
  `latitude` double(11, 6) NULL DEFAULT NULL COMMENT '设备纬度',
  `active_time` datetime(0) NULL DEFAULT NULL COMMENT '激活时间',
  `img_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片地址',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`device_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_device
-- ----------------------------
INSERT INTO `iot_device` VALUES (3, 'ESP8266开发板', 2, 'ESP8266产品示例', 1, 'admin', 1, 'admin', 'D6329VL54419L1Y0', 1.00, 4, -38, 1, 0, '[{\"id\": \"temperature\", \"value\": \"22.91\", \"shadow\": \"22.91\"}, {\"id\": \"humidity\", \"value\": \"42.85\", \"shadow\": \"42.85\"}, {\"id\": \"co2\", \"value\": \"682\", \"shadow\": \"682\"}, {\"id\": \"brightness\", \"value\": \"6349\", \"shadow\": \"6349\"}, {\"id\": \"switch\", \"value\": \"1\", \"shadow\": \"1\"}, {\"id\": \"gear\", \"value\": \"3\", \"shadow\": \"3\"}, {\"id\": \"light_color\", \"value\": \"255,100,120\", \"shadow\": \"255,100,120\"}, {\"id\": \"message\", \"value\": \"欢迎使用物美智能系统\", \"shadow\": \"欢迎使用物美智能系统\"}, {\"id\": \"report_monitor\", \"value\": \"1\", \"shadow\": \"1\"}]', ' 局域网', '172.17.0.1', 102.839445, 24.886272, '2022-03-15 00:00:00', NULL, '0', '', '2022-03-15 22:23:46', '', '2022-04-13 20:14:55', NULL);

-- ----------------------------
-- Table structure for iot_device_group
-- ----------------------------
DROP TABLE IF EXISTS `iot_device_group`;
CREATE TABLE `iot_device_group`  (
  `device_id` bigint(20) NOT NULL COMMENT '设备ID',
  `group_id` bigint(20) NOT NULL COMMENT '分组ID',
  PRIMARY KEY (`device_id`, `group_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备分组' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_device_group
-- ----------------------------

-- ----------------------------
-- Table structure for iot_device_job
-- ----------------------------
DROP TABLE IF EXISTS `iot_device_job`;
CREATE TABLE `iot_device_job`  (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注信息',
  `device_id` bigint(11) NOT NULL COMMENT '设备ID',
  `serial_number` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备编号',
  `device_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备名称',
  `is_advance` tinyint(1) NULL DEFAULT NULL COMMENT '是否详细corn表达式（1=是，0=否）',
  `actions` json NULL COMMENT '执行的动作集合',
  `job_type` tinyint(1) NULL DEFAULT NULL COMMENT '任务类型（1=设备定时，2=设备告警，3=场景联动）',
  `product_id` bigint(20) NOT NULL COMMENT '产品ID',
  `product_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品名称',
  `scene_id` bigint(20) NULL DEFAULT NULL COMMENT '场景联动ID',
  `alert_id` bigint(20) NULL DEFAULT NULL COMMENT '告警ID',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '设备定时' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_device_job
-- ----------------------------
INSERT INTO `iot_device_job` VALUES (1, '定时上报监测数据', 'DEFAULT', '0 20 10 ? * 1,2,3,4,5,6,7', '2', '1', '0', 'admin', '2022-03-15 22:38:42', 'admin', '2022-03-16 02:19:55', '', 3, 'D6329VL54419L1Y0', 'ESP8266开发板', 0, '[{\"id\": \"report_monitor\", \"name\": \"上报监测数据\", \"type\": 2, \"value\": \"1\", \"source\": 2, \"deviceId\": 3, \"alertName\": \"\", \"alertLevel\": 1, \"deviceName\": \"ESP8266开发板\"}, {\"id\": \"switch\", \"name\": \"设备开关\", \"type\": 2, \"value\": \"1\", \"source\": 2, \"deviceId\": 3, \"alertName\": \"\", \"alertLevel\": 1, \"deviceName\": \"ESP8266开发板\"}, {\"id\": \"gear\", \"name\": \"运行档位\", \"type\": 2, \"value\": \"3\", \"source\": 2, \"deviceId\": 3, \"alertName\": \"\", \"alertLevel\": 1, \"deviceName\": \"ESP8266开发板\"}]', 1, 2, 'ESP8266产品示例', NULL, NULL);

-- ----------------------------
-- Table structure for iot_device_log
-- ----------------------------
DROP TABLE IF EXISTS `iot_device_log`;
CREATE TABLE `iot_device_log`  (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '设备日志ID',
  `identity` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标识符',
  `log_type` tinyint(1) NOT NULL COMMENT '类型（1=属性上报，2=调用功能，3=事件上报，4=设备升级，5=设备上线，6=设备离线）',
  `log_value` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '日志值',
  `device_id` bigint(20) NOT NULL COMMENT '设备ID',
  `device_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备名称',
  `serial_number` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备编号',
  `is_monitor` tinyint(1) UNSIGNED ZEROFILL NOT NULL DEFAULT 0 COMMENT '是否监测数据（1=是，0=否）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `remark` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 651 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_device_log
-- ----------------------------
INSERT INTO `iot_device_log` VALUES (88, 'co2', 1, '605', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:31:20', '10165');
INSERT INTO `iot_device_log` VALUES (89, 'brightness', 1, '3792', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:31:21', '10165');
INSERT INTO `iot_device_log` VALUES (90, 'report_monitor', 2, '1', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 0, '', '2022-03-16 01:31:22', NULL);
INSERT INTO `iot_device_log` VALUES (91, 'offline', 6, '0', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 0, '', '2022-03-16 01:31:42', '设备离线');
INSERT INTO `iot_device_log` VALUES (92, 'online', 5, '1', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 0, '', '2022-03-16 01:31:53', '设备上线');
INSERT INTO `iot_device_log` VALUES (93, 'switch', 2, '0', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 0, '', '2022-03-16 01:32:31', NULL);
INSERT INTO `iot_device_log` VALUES (94, 'gear', 2, '3', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 0, '', '2022-03-16 01:32:36', NULL);
INSERT INTO `iot_device_log` VALUES (95, 'switch', 2, '1', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 0, '', '2022-03-16 01:32:38', NULL);
INSERT INTO `iot_device_log` VALUES (96, 'height_temperature', 3, '40', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 0, '', '2022-03-16 01:32:44', '温度过高警告');
INSERT INTO `iot_device_log` VALUES (97, 'exception', 3, '异常消息，消息内容XXXXXXXX', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 0, '', '2022-03-16 01:32:44', '设备发生错误');
INSERT INTO `iot_device_log` VALUES (98, 'temperature', 1, '20.08', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:32:45', '60011');
INSERT INTO `iot_device_log` VALUES (99, 'humidity', 1, '55.56', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:32:45', '60011');
INSERT INTO `iot_device_log` VALUES (100, 'co2', 1, '527', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:32:45', '60012');
INSERT INTO `iot_device_log` VALUES (101, 'brightness', 1, '8693', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:32:46', '60012');
INSERT INTO `iot_device_log` VALUES (102, 'temperature', 1, '25.07', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:32:56', '71197');
INSERT INTO `iot_device_log` VALUES (103, 'humidity', 1, '53.46', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:32:56', '71198');
INSERT INTO `iot_device_log` VALUES (104, 'co2', 1, '858', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:32:56', '71198');
INSERT INTO `iot_device_log` VALUES (105, 'brightness', 1, '1384', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:32:56', '71198');
INSERT INTO `iot_device_log` VALUES (106, 'report_monitor', 2, '1', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 0, '', '2022-03-16 01:32:57', NULL);
INSERT INTO `iot_device_log` VALUES (107, 'temperature', 1, '19.44', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:33:00', '76086');
INSERT INTO `iot_device_log` VALUES (108, 'humidity', 1, '40.74', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:33:01', '76087');
INSERT INTO `iot_device_log` VALUES (109, 'co2', 1, '884', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:33:01', '76087');
INSERT INTO `iot_device_log` VALUES (110, 'brightness', 1, '1928', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:33:01', '76087');
INSERT INTO `iot_device_log` VALUES (111, 'report_monitor', 2, '1', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 0, '', '2022-03-16 01:33:02', NULL);
INSERT INTO `iot_device_log` VALUES (112, 'height_temperature', 3, '40', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 0, '', '2022-03-16 01:33:44', '温度过高警告');
INSERT INTO `iot_device_log` VALUES (113, 'exception', 3, '异常消息，消息内容XXXXXXXX', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 0, '', '2022-03-16 01:33:44', '设备发生错误');
INSERT INTO `iot_device_log` VALUES (114, 'temperature', 1, '24.82', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:33:45', '120012');
INSERT INTO `iot_device_log` VALUES (115, 'humidity', 1, '46.32', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:33:45', '120012');
INSERT INTO `iot_device_log` VALUES (116, 'co2', 1, '510', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:33:45', '120013');
INSERT INTO `iot_device_log` VALUES (117, 'brightness', 1, '8830', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:33:46', '120013');
INSERT INTO `iot_device_log` VALUES (118, 'temperature', 1, '27.93', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:34:12', '147792');
INSERT INTO `iot_device_log` VALUES (119, 'humidity', 1, '30.24', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:34:12', '147792');
INSERT INTO `iot_device_log` VALUES (120, 'co2', 1, '932', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:34:13', '147792');
INSERT INTO `iot_device_log` VALUES (121, 'brightness', 1, '7267', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:34:13', '147792');
INSERT INTO `iot_device_log` VALUES (122, 'report_monitor', 2, '1', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 0, '', '2022-03-16 01:34:14', NULL);
INSERT INTO `iot_device_log` VALUES (123, 'temperature', 1, '12.51', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:34:22', '157691');
INSERT INTO `iot_device_log` VALUES (124, 'humidity', 1, '35.35', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:34:22', '157691');
INSERT INTO `iot_device_log` VALUES (125, 'co2', 1, '952', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:34:22', '157691');
INSERT INTO `iot_device_log` VALUES (126, 'brightness', 1, '9204', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:34:23', '157691');
INSERT INTO `iot_device_log` VALUES (127, 'report_monitor', 2, '1', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 0, '', '2022-03-16 01:34:24', NULL);
INSERT INTO `iot_device_log` VALUES (128, 'temperature', 1, '12.60', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:34:32', '167691');
INSERT INTO `iot_device_log` VALUES (129, 'humidity', 1, '53.09', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:34:32', '167691');
INSERT INTO `iot_device_log` VALUES (130, 'co2', 1, '569', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:34:33', '167691');
INSERT INTO `iot_device_log` VALUES (131, 'brightness', 1, '9485', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:34:33', '167691');
INSERT INTO `iot_device_log` VALUES (132, 'report_monitor', 2, '1', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 0, '', '2022-03-16 01:34:34', NULL);
INSERT INTO `iot_device_log` VALUES (133, 'temperature', 1, '19.49', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:34:42', '177590');
INSERT INTO `iot_device_log` VALUES (134, 'humidity', 1, '57.37', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:34:42', '177590');
INSERT INTO `iot_device_log` VALUES (135, 'co2', 1, '514', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:34:42', '177591');
INSERT INTO `iot_device_log` VALUES (136, 'brightness', 1, '2660', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:34:43', '177591');
INSERT INTO `iot_device_log` VALUES (137, 'report_monitor', 2, '1', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 0, '', '2022-03-16 01:34:43', NULL);
INSERT INTO `iot_device_log` VALUES (138, 'height_temperature', 3, '40', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 0, '', '2022-03-16 01:34:44', '温度过高警告');
INSERT INTO `iot_device_log` VALUES (139, 'exception', 3, '异常消息，消息内容XXXXXXXX', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 0, '', '2022-03-16 01:34:44', '设备发生错误');
INSERT INTO `iot_device_log` VALUES (140, 'temperature', 1, '24.67', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:34:45', '180013');
INSERT INTO `iot_device_log` VALUES (141, 'humidity', 1, '55.76', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:34:45', '180013');
INSERT INTO `iot_device_log` VALUES (142, 'co2', 1, '582', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:34:45', '180014');
INSERT INTO `iot_device_log` VALUES (143, 'brightness', 1, '4288', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:34:46', '180014');
INSERT INTO `iot_device_log` VALUES (144, 'temperature', 1, '22.47', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:34:52', '187756');
INSERT INTO `iot_device_log` VALUES (145, 'humidity', 1, '42.34', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:34:52', '187756');
INSERT INTO `iot_device_log` VALUES (146, 'co2', 1, '750', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:34:53', '187756');
INSERT INTO `iot_device_log` VALUES (147, 'brightness', 1, '8468', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:34:53', '187756');
INSERT INTO `iot_device_log` VALUES (148, 'report_monitor', 2, '1', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 0, '', '2022-03-16 01:34:54', NULL);
INSERT INTO `iot_device_log` VALUES (149, 'temperature', 1, '24.64', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:35:02', '197690');
INSERT INTO `iot_device_log` VALUES (150, 'humidity', 1, '56.93', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:35:02', '197690');
INSERT INTO `iot_device_log` VALUES (151, 'co2', 1, '841', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:35:02', '197690');
INSERT INTO `iot_device_log` VALUES (152, 'brightness', 1, '7910', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:35:03', '197691');
INSERT INTO `iot_device_log` VALUES (153, 'report_monitor', 2, '1', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 0, '', '2022-03-16 01:35:03', NULL);
INSERT INTO `iot_device_log` VALUES (154, 'temperature', 1, '10.00', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:35:12', '207704');
INSERT INTO `iot_device_log` VALUES (155, 'humidity', 1, '46.95', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:35:12', '207704');
INSERT INTO `iot_device_log` VALUES (156, 'co2', 1, '557', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:35:12', '207704');
INSERT INTO `iot_device_log` VALUES (157, 'brightness', 1, '6761', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:35:13', '207704');
INSERT INTO `iot_device_log` VALUES (158, 'report_monitor', 2, '1', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 0, '', '2022-03-16 01:35:14', NULL);
INSERT INTO `iot_device_log` VALUES (159, 'temperature', 1, '23.10', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:35:22', '217628');
INSERT INTO `iot_device_log` VALUES (160, 'humidity', 1, '36.57', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:35:22', '217628');
INSERT INTO `iot_device_log` VALUES (161, 'co2', 1, '531', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:35:22', '217628');
INSERT INTO `iot_device_log` VALUES (162, 'brightness', 1, '3486', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:35:23', '217629');
INSERT INTO `iot_device_log` VALUES (163, 'report_monitor', 2, '1', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 0, '', '2022-03-16 01:35:24', NULL);
INSERT INTO `iot_device_log` VALUES (164, 'temperature', 1, '23.82', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:35:32', '227731');
INSERT INTO `iot_device_log` VALUES (165, 'humidity', 1, '36.52', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:35:32', '227731');
INSERT INTO `iot_device_log` VALUES (166, 'co2', 1, '668', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:35:33', '227731');
INSERT INTO `iot_device_log` VALUES (167, 'brightness', 1, '7590', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:35:33', '227732');
INSERT INTO `iot_device_log` VALUES (168, 'report_monitor', 2, '1', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 0, '', '2022-03-16 01:35:34', NULL);
INSERT INTO `iot_device_log` VALUES (169, 'temperature', 1, '11.90', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:35:42', '237733');
INSERT INTO `iot_device_log` VALUES (170, 'humidity', 1, '45.83', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:35:42', '237734');
INSERT INTO `iot_device_log` VALUES (171, 'co2', 1, '995', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:35:42', '237734');
INSERT INTO `iot_device_log` VALUES (172, 'brightness', 1, '3961', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 1, '', '2022-03-16 01:35:43', '237734');
INSERT INTO `iot_device_log` VALUES (173, 'report_monitor', 2, '1', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 0, '', '2022-03-16 01:35:43', NULL);
INSERT INTO `iot_device_log` VALUES (174, 'height_temperature', 3, '40', 3, 'ESP8266开发板', 'D6329VL54419L1Y0', 0, '', '2022-03-16 01:35:44', '温度过高警告');

-- ----------------------------
-- Table structure for iot_device_user
-- ----------------------------
DROP TABLE IF EXISTS `iot_device_user`;
CREATE TABLE `iot_device_user`  (
  `device_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '设备ID',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `tenant_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '租户名称',
  `device_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备名称',
  `phonenumber` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户昵称',
  `is_owner` tinyint(11) NOT NULL COMMENT '是否为设备所有者（0=否，1=是）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`device_id`, `user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备用户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_device_user
-- ----------------------------

-- ----------------------------
-- Table structure for iot_firmware
-- ----------------------------
DROP TABLE IF EXISTS `iot_firmware`;
CREATE TABLE `iot_firmware`  (
  `firmware_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '固件ID',
  `firmware_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '固件名称',
  `product_id` bigint(20) NOT NULL COMMENT '产品ID',
  `product_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '产品名称',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `tenant_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '租户名称',
  `is_sys` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否系统通用（0-否，1-是）',
  `version` float(11, 2) NOT NULL DEFAULT 0.10 COMMENT '固件版本',
  `file_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '文件路径',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`firmware_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品固件' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_firmware
-- ----------------------------
INSERT INTO `iot_firmware` VALUES (4, '11', 2, 'ESP8266产品示例', 1, 'admin', 1, 1.00, '/profile/iot/1/2022-0415-165518.bin', '0', '', '2022-04-15 16:55:21', '', NULL, '1');

-- ----------------------------
-- Table structure for iot_group
-- ----------------------------
DROP TABLE IF EXISTS `iot_group`;
CREATE TABLE `iot_group`  (
  `group_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '分组ID',
  `group_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分组名称',
  `group_order` tinyint(11) NOT NULL DEFAULT 0 COMMENT '分组排序',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户昵称',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`group_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备分组' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_group
-- ----------------------------
INSERT INTO `iot_group` VALUES (1, '客厅', 1, 1, 'admin', '0', '', '2021-12-29 13:13:26', '', '2021-12-29 13:14:11', '客厅设备');
INSERT INTO `iot_group` VALUES (2, '卧室', 2, 1, 'admin', '0', '', '2021-12-29 13:12:42', '', '2021-12-29 13:13:40', '卧室设备');
INSERT INTO `iot_group` VALUES (3, '厨房', 3, 1, 'admin', '0', '', '2021-12-29 13:12:59', '', '2021-12-29 13:13:48', '厨房设备');
INSERT INTO `iot_group` VALUES (4, '书房', 4, 1, 'admin', '0', '', '2021-12-29 13:13:10', '', '2021-12-29 13:13:54', '书房设备');
INSERT INTO `iot_group` VALUES (5, '卫生间', 5, 1, 'admin', '0', '', '2021-12-29 13:13:18', '', '2021-12-29 13:14:03', '卫生间设备');
INSERT INTO `iot_group` VALUES (6, '走道', 6, 1, 'admin', '0', '', '2021-12-29 13:13:26', '', '2021-12-29 13:14:11', '走道设备');

-- ----------------------------
-- Table structure for iot_product
-- ----------------------------
DROP TABLE IF EXISTS `iot_product`;
CREATE TABLE `iot_product`  (
  `product_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '产品ID',
  `product_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '产品名称',
  `category_id` bigint(20) NOT NULL COMMENT '产品分类ID',
  `category_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '产品分类名称',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `tenant_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '租户名称',
  `is_sys` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否系统通用（0-否，1-是）',
  `is_authorize` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否启用授权码（0-否，1-是）',
  `mqtt_account` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'mqtt账号',
  `mqtt_password` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'mqtt密码',
  `mqtt_secret` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品秘钥',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '状态（1-未发布，2-已发布）',
  `things_models_json` json NULL COMMENT '物模型JSON（属性、功能、事件）',
  `device_type` tinyint(1) NULL DEFAULT 1 COMMENT '设备类型（1-直连设备、2-网关子设备、3-网关设备）',
  `network_method` tinyint(1) NULL DEFAULT 1 COMMENT '联网方式（1-wifi、2-蓝牙、3-wifi+蓝牙）',
  `vertificate_method` tinyint(1) NULL DEFAULT 1 COMMENT '认证方式（1-账号密码、2-证书、3-Http）',
  `img_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片地址',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`product_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_product
-- ----------------------------
INSERT INTO `iot_product` VALUES (2, 'ESP8266产品示例', 1, '电工照明', 1, 'admin', 1, 1, 'wumei-smart', 'P5FJKZJHIR82GNB2', 'K63C4EA3AI5TER97', 2, '{\"events\": [{\"id\": \"exception\", \"name\": \"设备发生异常\", \"datatype\": {\"type\": \"string\", \"maxLength\": 1024}}, {\"id\": \"height_temperature\", \"name\": \"环境温度过高\", \"datatype\": {\"max\": 100, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}}], \"functions\": [{\"id\": \"switch\", \"name\": \"设备开关\", \"isTop\": 1, \"datatype\": {\"type\": \"bool\", \"trueText\": \"打开\", \"falseText\": \"关闭\"}}, {\"id\": \"gear\", \"name\": \"运行档位\", \"isTop\": 1, \"datatype\": {\"type\": \"enum\", \"enumList\": [{\"text\": \"低速档位\", \"value\": \"0\"}, {\"text\": \"中速档位\", \"value\": \"1\"}, {\"text\": \"中高速档位\", \"value\": \"2\"}, {\"text\": \"高速档位\", \"value\": \"3\"}]}}, {\"id\": \"light_color\", \"name\": \"灯光颜色\", \"isTop\": 0, \"datatype\": {\"type\": \"array\", \"arrayType\": \"int\"}}, {\"id\": \"message\", \"name\": \"屏显消息\", \"isTop\": 0, \"datatype\": {\"type\": \"string\", \"maxLength\": 1024}}, {\"id\": \"report_monitor\", \"name\": \"上报监测数据\", \"isTop\": 0, \"datatype\": {\"max\": 10, \"min\": 1, \"step\": 1, \"type\": \"integer\", \"unit\": \"次数\"}}], \"properties\": [{\"id\": \"temperature\", \"name\": \"空气温度\", \"isTop\": 1, \"datatype\": {\"max\": 120, \"min\": -20, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}, \"isMonitor\": 1}, {\"id\": \"humidity\", \"name\": \"空气湿度\", \"isTop\": 1, \"datatype\": {\"max\": 100, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"%\"}, \"isMonitor\": 1}, {\"id\": \"co2\", \"name\": \"二氧化碳\", \"isTop\": 0, \"datatype\": {\"max\": 6000, \"min\": 100, \"step\": 1, \"type\": \"integer\", \"unit\": \"ppm\"}, \"isMonitor\": 1}, {\"id\": \"brightness\", \"name\": \"室内亮度\", \"isTop\": 0, \"datatype\": {\"max\": 10000, \"min\": 0, \"step\": 1, \"type\": \"integer\", \"unit\": \"cd/m2\"}, \"isMonitor\": 1}]}', 1, 1, 3, NULL, '0', '', '2022-03-15 22:18:37', '', '2022-04-11 14:13:40', '产品示例');

-- ----------------------------
-- Table structure for iot_product_authorize
-- ----------------------------
DROP TABLE IF EXISTS `iot_product_authorize`;
CREATE TABLE `iot_product_authorize`  (
  `authorize_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '授权码ID',
  `authorize_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '授权码',
  `product_id` bigint(20) NOT NULL COMMENT '产品ID',
  `device_id` bigint(20) NULL DEFAULT NULL COMMENT '设备ID',
  `serial_number` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备编号',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户名称',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`authorize_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 104 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '产品授权码表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_product_authorize
-- ----------------------------

-- ----------------------------
-- Table structure for iot_scene
-- ----------------------------
DROP TABLE IF EXISTS `iot_scene`;
CREATE TABLE `iot_scene`  (
  `scene_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '场景ID',
  `scene_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '场景名称',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `user_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名称',
  `triggers` json NOT NULL COMMENT '触发器',
  `actions` json NOT NULL COMMENT '执行动作',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`scene_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '场景联动' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_scene
-- ----------------------------

-- ----------------------------
-- Table structure for iot_social_platform
-- ----------------------------
DROP TABLE IF EXISTS `iot_social_platform`;
CREATE TABLE `iot_social_platform`  (
  `social_platform_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '第三方登录平台主键',
  `platform` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '第三方登录平台',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT ' 0:启用 ,1:禁用',
  `client_id` varchar(48) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '第三方平台申请Id',
  `secret_key` varchar(48) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '第三方平台密钥',
  `redirect_uri` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户认证后跳转地址',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '删除标记位(0代表存在，1代表删除)',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '创建者',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `bind_uri` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '绑定注册登录uri,http://localhost/login?bindId=',
  `redirect_login_uri` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '跳转登录uri,http://localhost/login?loginId=',
  `error_msg_uri` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '错误提示uri,http://localhost/login?errorId=',
  PRIMARY KEY (`social_platform_id`) USING BTREE,
  UNIQUE INDEX `iot_social_platform_platform_uindex`(`platform`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '第三方登录平台控制' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_social_platform
-- ----------------------------

-- ----------------------------
-- Table structure for iot_social_user
-- ----------------------------
DROP TABLE IF EXISTS `iot_social_user`;
CREATE TABLE `iot_social_user`  (
  `social_user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '第三方系统用户表主键',
  `uuid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '第三方系统的唯一ID',
  `source` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '第三方用户来源',
  `access_token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户的授权令牌',
  `expire_in` int(11) NULL DEFAULT NULL COMMENT '第三方用户的授权令牌的有效期（部分平台可能没有）',
  `refresh_token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '刷新令牌(部分平台可能没有)',
  `open_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '第三方用户的 open id（部分平台可能没有）',
  `uid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '第三方用户的 ID(部分平台可能没有)',
  `access_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '个别平台的授权信息（部分平台可能没有）',
  `union_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '第三方用户的 union id(部分平台可能没有)',
  `scope` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '第三方用户授予的权限(部分平台可能没有)',
  `token_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '个别平台的授权信息（部分平台可能没有）',
  `id_token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'id token（部分平台可能没有）',
  `mac_algorithm` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '小米平台用户的附带属性（部分平台可能没有）',
  `mac_key` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '小米平台用户的附带属性(部分平台可能没有)',
  `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户的授权code（部分平台可能没有）',
  `oauth_token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Twitter平台用户的附带属性(部分平台可能没有)',
  `oauth_token_secret` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Twitter平台用户的附带属性(部分平台可能没有)',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '创建者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '删除标记位(0代表存在,2代表删除)',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '绑定状态(0:未绑定,1:绑定)',
  `sys_user_id` int(11) NULL DEFAULT NULL COMMENT '用户ID',
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `nickname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `avatar` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户头像',
  `gender` tinyint(4) NULL DEFAULT NULL COMMENT '用户性别',
  UNIQUE INDEX `iot_social_user_pk`(`social_user_id`) USING BTREE,
  UNIQUE INDEX `iot_social_user_unique_key`(`uuid`, `source`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_social_user
-- ----------------------------

-- ----------------------------
-- Table structure for iot_things_model
-- ----------------------------
DROP TABLE IF EXISTS `iot_things_model`;
CREATE TABLE `iot_things_model`  (
  `model_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '物模型ID',
  `model_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '物模型名称',
  `product_id` bigint(20) NOT NULL COMMENT '产品ID',
  `product_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '产品名称',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `tenant_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '租户名称',
  `identifier` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标识符，产品下唯一',
  `type` tinyint(1) NOT NULL COMMENT '模型类别（1-属性，2-功能，3-事件）',
  `datatype` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据类型（integer、decimal、string、bool、array、enum）',
  `specs` json NOT NULL COMMENT '数据定义',
  `is_Top` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否首页显示（0-否，1-是）',
  `is_Monitor` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否实时监测（0-否，1-是）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`model_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '物模型模板' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_things_model
-- ----------------------------
INSERT INTO `iot_things_model` VALUES (11, '空气温度', 2, 'ESP8266产品示例', 1, 'admin', 'temperature', 1, 'decimal', '{\"max\": 120, \"min\": -20, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}', 1, 1, '0', NULL, '2022-03-15 22:18:46', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (12, '空气湿度', 2, 'ESP8266产品示例', 1, 'admin', 'humidity', 1, 'decimal', '{\"max\": 100, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"%\"}', 1, 1, '0', NULL, '2022-03-15 22:18:46', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (13, '二氧化碳', 2, 'ESP8266产品示例', 1, 'admin', 'co2', 1, 'integer', '{\"max\": 6000, \"min\": 100, \"step\": 1, \"type\": \"integer\", \"unit\": \"ppm\"}', 0, 1, '0', NULL, '2022-03-15 22:18:46', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (14, '室内亮度', 2, 'ESP8266产品示例', 1, 'admin', 'brightness', 1, 'integer', '{\"max\": 10000, \"min\": 0, \"step\": 1, \"type\": \"integer\", \"unit\": \"cd/m2\"}', 0, 1, '0', NULL, '2022-03-15 22:18:46', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (15, '设备开关', 2, 'ESP8266产品示例', 1, 'admin', 'switch', 2, 'bool', '{\"type\": \"bool\", \"trueText\": \"打开\", \"falseText\": \"关闭\"}', 1, 0, '0', NULL, '2022-03-15 22:18:46', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (16, '运行档位', 2, 'ESP8266产品示例', 1, 'admin', 'gear', 2, 'enum', '{\"type\": \"enum\", \"enumList\": [{\"text\": \"低速档位\", \"value\": \"0\"}, {\"text\": \"中速档位\", \"value\": \"1\"}, {\"text\": \"中高速档位\", \"value\": \"2\"}, {\"text\": \"高速档位\", \"value\": \"3\"}]}', 1, 0, '0', NULL, '2022-03-15 22:18:46', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (17, '灯光颜色', 2, 'ESP8266产品示例', 1, 'admin', 'light_color', 2, 'array', '{\"type\": \"array\", \"arrayType\": \"int\"}', 0, 0, '0', NULL, '2022-03-15 22:18:46', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (18, '屏显消息', 2, 'ESP8266产品示例', 1, 'admin', 'message', 2, 'string', '{\"type\": \"string\", \"maxLength\": 1024}', 0, 0, '0', NULL, '2022-03-15 22:18:46', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (19, '上报监测数据', 2, 'ESP8266产品示例', 1, 'admin', 'report_monitor', 2, 'integer', '{\"max\": 10, \"min\": 1, \"step\": 1, \"type\": \"integer\", \"unit\": \"次数\"}', 0, 0, '0', NULL, '2022-03-15 22:18:46', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (20, '环境温度过高', 2, 'ESP8266产品示例', 1, 'admin', 'height_temperature', 3, 'decimal', '{\"max\": 100, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}', 0, 0, '0', NULL, '2022-03-15 22:18:46', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (21, '设备发生异常', 2, 'ESP8266产品示例', 1, 'admin', 'exception', 3, 'string', '{\"type\": \"string\", \"maxLength\": 1024}', 0, 0, '0', NULL, '2022-03-15 22:18:52', '', NULL, NULL);

-- ----------------------------
-- Table structure for iot_things_model_template
-- ----------------------------
DROP TABLE IF EXISTS `iot_things_model_template`;
CREATE TABLE `iot_things_model_template`  (
  `template_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '物模型ID',
  `template_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '物模型名称',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `tenant_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '租户名称',
  `identifier` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标识符，产品下唯一',
  `type` tinyint(1) NOT NULL COMMENT '模型类别（1-属性，2-功能，3-事件）',
  `datatype` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据类型（integer、decimal、string、bool、array、enum）',
  `specs` json NOT NULL COMMENT '数据定义',
  `is_sys` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否系统通用（0-否，1-是）',
  `is_Top` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否首页显示（0-否，1-是）',
  `is_Monitor` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否实时监测（0-否，1-是）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`template_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '物模型模板' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_things_model_template
-- ----------------------------
INSERT INTO `iot_things_model_template` VALUES (1, '空气温度', 1, 'admin', 'temperature', 1, 'decimal', '{\"max\": 120, \"min\": -20, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}', 1, 1, 1, '0', 'admin', '2022-03-09 17:41:49', '', '2022-03-09 20:58:06', NULL);
INSERT INTO `iot_things_model_template` VALUES (2, '空气湿度', 1, 'admin', 'humidity', 1, 'decimal', '{\"max\": 100, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"%\"}', 1, 1, 1, '0', 'admin', '2022-03-09 17:41:49', '', '2022-03-11 00:11:08', NULL);
INSERT INTO `iot_things_model_template` VALUES (3, '二氧化碳', 1, 'admin', 'co2', 1, 'integer', '{\"max\": 6000, \"min\": 100, \"step\": 1, \"type\": \"integer\", \"unit\": \"ppm\"}', 1, 0, 1, '0', 'admin', '2022-03-09 17:41:49', '', '2022-03-11 00:10:09', NULL);
INSERT INTO `iot_things_model_template` VALUES (4, '室内亮度', 1, 'admin', 'brightness', 1, 'integer', '{\"max\": 10000, \"min\": 0, \"step\": 1, \"type\": \"integer\", \"unit\": \"cd/m2\"}', 1, 0, 1, '0', 'admin', '2022-03-09 17:41:49', '', '2022-03-11 00:10:17', NULL);
INSERT INTO `iot_things_model_template` VALUES (5, '设备开关', 1, 'admin', 'switch', 2, 'bool', '{\"type\": \"bool\", \"trueText\": \"打开\", \"falseText\": \"关闭\"}', 1, 1, 0, '0', 'admin', '2022-03-09 17:41:49', '', '2022-03-09 17:41:49', NULL);
INSERT INTO `iot_things_model_template` VALUES (6, '运行档位', 1, 'admin', 'gear', 2, 'enum', '{\"type\": \"enum\", \"enumList\": [{\"text\": \"低速档位\", \"value\": \"0\"}, {\"text\": \"中速档位\", \"value\": \"1\"}, {\"text\": \"中高速档位\", \"value\": \"2\"}, {\"text\": \"高速档位\", \"value\": \"3\"}]}', 1, 1, 0, '0', 'admin', '2022-03-09 17:41:49', '', '2022-03-09 17:41:49', NULL);
INSERT INTO `iot_things_model_template` VALUES (7, '灯光颜色', 1, 'admin', 'light_color', 2, 'array', '{\"type\": \"array\", \"arrayType\": \"int\"}', 1, 0, 0, '0', 'admin', '2022-03-09 17:41:49', '', '2022-03-11 00:54:11', NULL);
INSERT INTO `iot_things_model_template` VALUES (8, '屏显消息', 1, 'admin', 'message', 2, 'string', '{\"type\": \"string\", \"maxLength\": 1024}', 1, 0, 0, '0', 'admin', '2022-03-09 17:41:49', '', '2022-03-09 17:41:49', NULL);
INSERT INTO `iot_things_model_template` VALUES (9, '上报监测数据', 1, 'admin', 'report_monitor', 2, 'integer', '{\"max\": 10, \"min\": 1, \"step\": 1, \"type\": \"integer\", \"unit\": \"次数\"}', 1, 0, 0, '0', 'admin', '2022-03-09 17:41:49', '', '2022-03-09 17:41:49', NULL);
INSERT INTO `iot_things_model_template` VALUES (10, '环境温度过高', 1, 'admin', 'height_temperature', 3, 'decimal', '{\"max\": 100, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}', 1, 0, 0, '0', 'admin', '2022-03-09 17:41:49', '', '2022-03-11 14:48:21', NULL);
INSERT INTO `iot_things_model_template` VALUES (11, '设备发生异常', 1, 'admin', 'exception', 3, 'string', '{\"type\": \"string\", \"maxLength\": 1024}', 1, 0, 0, '0', 'admin', '2022-03-09 17:41:49', '', '2022-03-09 17:41:49', NULL);

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`  (
  `news_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '新闻ID',
  `title` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容',
  `img_url` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '封面',
  `is_top` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否置顶(0-置顶 1-置顶)',
  `is_banner` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否banner(0-是banner 1-不是banner)',
  `category_id` bigint(20) NOT NULL COMMENT '分类ID',
  `category_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类名称',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '新闻状态（0-未发布，1-已发布）',
  `author` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '作者',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`news_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '新闻资讯' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of news
-- ----------------------------

-- ----------------------------
-- Table structure for news_category
-- ----------------------------
DROP TABLE IF EXISTS `news_category`;
CREATE TABLE `news_category`  (
  `category_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `category_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类名称',
  `order_num` int(2) NOT NULL COMMENT '显示顺序',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '新闻分类' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of news_category
-- ----------------------------
INSERT INTO `news_category` VALUES (1, '新闻资讯', 3, '0', '', '2022-04-11 20:53:55', '', '2022-04-13 15:30:22', '新闻资讯信息');
INSERT INTO `news_category` VALUES (2, '相关产品', 2, '0', '', '2022-04-11 20:54:16', '', '2022-04-13 15:30:15', '相关产品推荐');
INSERT INTO `news_category` VALUES (4, '通知消息', 1, '0', '', '2022-04-13 15:29:16', '', '2022-04-13 15:30:31', '系统通知消息');

-- ----------------------------
-- Table structure for oauth_access_token
-- ----------------------------
DROP TABLE IF EXISTS `oauth_access_token`;
CREATE TABLE `oauth_access_token`  (
  `token_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `token` blob NULL,
  `authentication_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `client_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `authentication` blob NULL,
  `refresh_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oauth_access_token
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_approvals
-- ----------------------------
DROP TABLE IF EXISTS `oauth_approvals`;
CREATE TABLE `oauth_approvals`  (
  `userId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `clientId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `scope` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `expiresAt` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  `lastModifiedAt` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oauth_approvals
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_client_details
-- ----------------------------
DROP TABLE IF EXISTS `oauth_client_details`;
CREATE TABLE `oauth_client_details`  (
  `client_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户端ID',
  `resource_ids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户端所能访问的资源id集合,多个资源时用逗号(,)分隔',
  `client_secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户端秘钥',
  `scope` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限范围,可选值包括read,write,trust;若有多个权限范围用逗号(,)分隔',
  `authorized_grant_types` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '授权模式，可选值包括authorization_code,password,refresh_token,implicit,client_credentials, 若支持多个grant_type用逗号(,)分隔',
  `web_server_redirect_uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '回调地址',
  `authorities` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限',
  `access_token_validity` int(11) NULL DEFAULT NULL COMMENT '设定客户端的access_token的有效时间值(单位:秒)',
  `refresh_token_validity` int(11) NULL DEFAULT NULL COMMENT '设定客户端的refresh_token的有效时间值(单位:秒)',
  `additional_information` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '预留的字段,在Oauth的流程中没有实际的使用,可选,但若设置值,必须是JSON格式的数据',
  `autoapprove` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设置用户是否自动Approval操作, 默认值为 \'false\', 可选值包括 \'true\',\'false\', \'read\',\'write\'. \n该字段只适用于grant_type=\"authorization_code\"的情况,当用户登录成功后,若该值为\'true\'或支持的scope值,则会跳过用户Approve的页面, 直接授权. ',
  `type` tinyint(1) NULL DEFAULT NULL COMMENT '1=小度(DuerOS),2=天猫精灵(ALiGenie),3=小米小爱',
  PRIMARY KEY (`client_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oauth_client_details
-- ----------------------------
INSERT INTO `oauth_client_details` VALUES ('speaker', 'speaker-service', '$2a$10$jMEhxWXpc6KsMyFF0JJ3kuoVHOp.tEsTCvaJHnQqfGtYKo4.scv/m', 'read,write', 'client_credentials,password,authorization_code,implicit,refresh_token', 'https://xiaodu.baidu.com/saiya/auth/22c6bd1489c8396f00cc25bf2d9d0206', 'ROLE_ADMIN', 7200, 7200, NULL, 'false', 1);
INSERT INTO `oauth_client_details` VALUES ('tianmao', 'speaker-service', '$2a$10$jMEhxWXpc6KsMyFF0JJ3kuoVHOp.tEsTCvaJHnQqfGtYKo4.scv/m', 'read,write', 'authorization_code,refresh_token', '\r\nhttps://xiaodu.baidu.com/saiya/auth/22c6bd1489c8396f00cc25bf2d9d0206', 'ROLE_ADMIN', 7200, 7200, NULL, 'true', 2);
INSERT INTO `oauth_client_details` VALUES ('xiaoai', 'speaker-service', '$2a$10$jMEhxWXpc6KsMyFF0JJ3kuoVHOp.tEsTCvaJHnQqfGtYKo4.scv/m', 'read,write', 'authorization_code,refresh_token', 'https://xiaodu.baidu.com/saiya/auth/22c6bd1489c8396f00cc25bf2d9d0206', 'ROLE_ADMIN', 7200, 7200, NULL, 'true', 3);
INSERT INTO `oauth_client_details` VALUES ('xiaoyi', 'speaker-service', '$2a$10$jMEhxWXpc6KsMyFF0JJ3kuoVHOp.tEsTCvaJHnQqfGtYKo4.scv/m', 'read,write', 'authorization_code,refresh_token', 'https://xiaodu.baidu.com/saiya/auth/22c6bd1489c8396f00cc25bf2d9d0206', 'ROLE_ADMIN', 7200, 7200, NULL, 'false', 4);

-- ----------------------------
-- Table structure for oauth_client_token
-- ----------------------------
DROP TABLE IF EXISTS `oauth_client_token`;
CREATE TABLE `oauth_client_token`  (
  `token_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `token` blob NULL,
  `authentication_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `client_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oauth_client_token
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_code
-- ----------------------------
DROP TABLE IF EXISTS `oauth_code`;
CREATE TABLE `oauth_code`  (
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `authentication` blob NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oauth_code
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_refresh_token
-- ----------------------------
DROP TABLE IF EXISTS `oauth_refresh_token`;
CREATE TABLE `oauth_refresh_token`  (
  `token_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `token` blob NULL,
  `authentication` blob NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oauth_refresh_token
-- ----------------------------

-- ----------------------------
-- Table structure for sys_auth_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_auth_user`;
CREATE TABLE `sys_auth_user`  (
  `auth_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '授权ID',
  `uuid` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '第三方平台用户唯一ID',
  `user_id` bigint(20) NOT NULL COMMENT '系统用户ID',
  `login_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录账号',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户昵称',
  `avatar` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户来源',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`auth_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '第三方授权表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_auth_user
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int(5) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2021-12-15 21:36:18', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2021-12-15 21:36:18', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2021-12-15 21:36:18', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaOnOff', 'true', 'Y', 'admin', '2021-12-15 21:36:18', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'true', 'Y', 'admin', '2021-12-15 21:36:18', 'admin', '2021-12-24 22:43:33', '是否开启注册用户功能（true开启，false关闭）');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int(4) NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '物美智能', 0, '物美', '15888888888', '164770707@qq.com', '0', '0', 'admin', '2021-12-15 21:36:18', '', NULL);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '北京总公司', 1, '物美', '15888888888', '164770707@qq.com', '0', '0', 'admin', '2021-12-15 21:36:18', 'admin', '2022-03-09 16:49:53');
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '昆明分公司', 2, '物美', '15888888888', '164770707@qq.com', '0', '0', 'admin', '2021-12-15 21:36:18', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '物美', '15888888888', '164770707@qq.com', '1', '0', 'admin', '2021-12-15 21:36:18', 'admin', '2022-02-01 23:12:40');
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '物美', '15888888888', '164770707@qq.com', '0', '0', 'admin', '2021-12-15 21:36:18', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '物美', '15888888888', '164770707@qq.com', '0', '0', 'admin', '2021-12-15 21:36:18', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '物美', '15888888888', '164770707@qq.com', '0', '0', 'admin', '2021-12-15 21:36:18', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '物美', '15888888888', '164770707@qq.com', '0', '0', 'admin', '2021-12-15 21:36:18', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '物美', '15888888888', '164770707@qq.com', '0', '0', 'admin', '2021-12-15 21:36:18', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '物美', '15888888888', '164770707@qq.com', '0', '0', 'admin', '2021-12-15 21:36:18', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(4) NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 154 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (19, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (20, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (21, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (22, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (23, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (24, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (25, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (26, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (27, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (28, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (100, 1, '属性', '1', 'iot_things_type', '', 'primary', 'Y', '0', 'admin', '2021-12-12 16:41:15', 'admin', '2021-12-15 22:49:37', '');
INSERT INTO `sys_dict_data` VALUES (101, 2, '功能', '2', 'iot_things_type', '', 'success', 'Y', '0', 'admin', '2021-12-12 16:43:33', 'admin', '2021-12-14 16:33:11', '');
INSERT INTO `sys_dict_data` VALUES (102, 3, '事件', '3', 'iot_things_type', NULL, 'warning', 'Y', '0', 'admin', '2021-12-12 16:46:04', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (103, 1, '整数', 'integer', 'iot_data_type', '', '', 'Y', '0', 'admin', '2021-12-12 20:20:46', 'admin', '2021-12-14 16:09:56', '');
INSERT INTO `sys_dict_data` VALUES (104, 2, '小数', 'decimal', 'iot_data_type', NULL, 'default', 'Y', '0', 'admin', '2021-12-12 20:21:21', 'admin', '2021-12-15 22:51:07', NULL);
INSERT INTO `sys_dict_data` VALUES (105, 3, '布尔', 'bool', 'iot_data_type', NULL, 'default', 'Y', '0', 'admin', '2021-12-12 20:22:12', 'admin', '2021-12-15 22:51:02', NULL);
INSERT INTO `sys_dict_data` VALUES (106, 4, '枚举', 'enum', 'iot_data_type', NULL, 'default', 'Y', '0', 'admin', '2021-12-12 20:22:37', 'admin', '2021-12-15 22:50:57', NULL);
INSERT INTO `sys_dict_data` VALUES (107, 5, '字符串', 'string', 'iot_data_type', NULL, 'default', 'Y', '0', 'admin', '2021-12-12 20:22:54', 'admin', '2021-12-15 22:50:52', NULL);
INSERT INTO `sys_dict_data` VALUES (108, 1, '是', '1', 'iot_yes_no', '', 'default', 'Y', '0', 'admin', '2021-12-12 20:25:14', 'admin', '2022-01-02 13:39:09', '');
INSERT INTO `sys_dict_data` VALUES (109, 2, '否', '0', 'iot_yes_no', '', 'default', 'Y', '0', 'admin', '2021-12-12 20:25:25', 'admin', '2022-01-02 13:39:15', '');
INSERT INTO `sys_dict_data` VALUES (110, 6, '数组', 'array', 'iot_data_type', NULL, 'default', 'Y', '0', 'admin', '2021-12-13 18:18:04', 'admin', '2021-12-15 22:50:42', NULL);
INSERT INTO `sys_dict_data` VALUES (111, 1, '未发布', '1', 'iot_product_status', NULL, 'info', 'N', '0', 'admin', '2021-12-19 15:01:18', 'admin', '2021-12-19 15:01:55', NULL);
INSERT INTO `sys_dict_data` VALUES (112, 2, '已发布', '2', 'iot_product_status', NULL, 'success', 'N', '0', 'admin', '2021-12-19 15:01:43', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (113, 1, '直连设备', '1', 'iot_device_type', NULL, 'default', 'N', '0', 'admin', '2021-12-19 15:03:49', 'admin', '2021-12-19 15:10:13', NULL);
INSERT INTO `sys_dict_data` VALUES (114, 3, '网关设备', '3', 'iot_device_type', NULL, 'default', 'N', '0', 'admin', '2021-12-19 15:04:28', 'admin', '2021-12-19 15:10:30', NULL);
INSERT INTO `sys_dict_data` VALUES (115, 2, '网关子设备', '2', 'iot_device_type', NULL, 'default', 'N', '0', 'admin', '2021-12-19 15:05:52', 'admin', '2021-12-19 15:10:23', NULL);
INSERT INTO `sys_dict_data` VALUES (116, 1, 'WIFI', '1', 'iot_network_method', NULL, 'default', 'N', '0', 'admin', '2021-12-19 15:07:35', 'admin', '2021-12-22 00:11:19', NULL);
INSERT INTO `sys_dict_data` VALUES (117, 2, '蜂窝(2G/3G/4G/5G)', '2', 'iot_network_method', NULL, 'default', 'N', '0', 'admin', '2021-12-19 15:08:30', 'admin', '2022-01-14 02:12:27', NULL);
INSERT INTO `sys_dict_data` VALUES (118, 3, '以太网', '3', 'iot_network_method', NULL, 'default', 'N', '0', 'admin', '2021-12-19 15:09:08', 'admin', '2022-01-14 02:12:39', NULL);
INSERT INTO `sys_dict_data` VALUES (119, 1, '账号密码', '1', 'iot_vertificate_method', NULL, 'default', 'N', '0', 'admin', '2021-12-19 15:13:16', 'admin', '2021-12-19 15:13:44', NULL);
INSERT INTO `sys_dict_data` VALUES (120, 2, '证书', '2', 'iot_vertificate_method', NULL, 'default', 'N', '0', 'admin', '2021-12-19 15:13:26', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (121, 3, 'Http', '3', 'iot_vertificate_method', NULL, 'default', 'N', '0', 'admin', '2021-12-19 15:13:37', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (122, 1, 'ESP8266/Arduino', '1', 'iot_device_chip', NULL, 'default', 'N', '0', 'admin', '2021-12-24 15:54:52', 'admin', '2021-12-24 16:07:31', NULL);
INSERT INTO `sys_dict_data` VALUES (123, 3, 'ESP32/Arduino', '2', 'iot_device_chip', NULL, 'default', 'N', '0', 'admin', '2021-12-24 15:55:04', 'admin', '2021-12-24 16:07:26', NULL);
INSERT INTO `sys_dict_data` VALUES (124, 2, 'ESP8266/RTOS', '3', 'iot_device_chip', NULL, 'default', 'N', '0', 'admin', '2021-12-24 15:56:08', 'admin', '2021-12-24 16:07:17', NULL);
INSERT INTO `sys_dict_data` VALUES (127, 4, 'ESP32/ESP-IDF', '4', 'iot_device_chip', NULL, 'default', 'N', '0', 'admin', '2021-12-24 16:07:54', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (128, 5, '树莓派/Python', '5', 'iot_device_chip', NULL, 'default', 'N', '0', 'admin', '2021-12-24 16:08:31', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (129, 0, '未激活', '1', 'iot_device_status', NULL, 'warning', 'N', '0', 'admin', '2021-12-27 22:21:04', 'admin', '2021-12-27 22:22:09', NULL);
INSERT INTO `sys_dict_data` VALUES (130, 0, '禁用', '2', 'iot_device_status', NULL, 'danger', 'N', '0', 'admin', '2021-12-27 22:21:22', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (131, 0, '在线', '3', 'iot_device_status', NULL, 'success', 'N', '0', 'admin', '2021-12-27 22:21:42', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (132, 0, '离线', '4', 'iot_device_status', NULL, 'info', 'N', '0', 'admin', '2021-12-27 22:22:01', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (133, 0, '启用', '1', 'iot_is_enable', NULL, 'success', 'N', '0', 'admin', '2022-01-12 23:25:08', 'admin', '2022-01-12 23:25:30', NULL);
INSERT INTO `sys_dict_data` VALUES (134, 0, '禁用', '0', 'iot_is_enable', NULL, 'info', 'N', '0', 'admin', '2022-01-12 23:25:19', 'admin', '2022-01-12 23:25:38', NULL);
INSERT INTO `sys_dict_data` VALUES (135, 0, '提醒通知', '1', 'iot_alert_level', NULL, 'success', 'N', '0', 'admin', '2022-01-13 14:58:10', 'admin', '2022-01-13 14:58:31', NULL);
INSERT INTO `sys_dict_data` VALUES (136, 0, '轻微问题', '2', 'iot_alert_level', NULL, 'warning', 'N', '0', 'admin', '2022-01-13 14:59:00', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (137, 0, '严重警告', '3', 'iot_alert_level', NULL, 'danger', 'N', '0', 'admin', '2022-01-13 14:59:16', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (138, 0, '不需要处理', '1', 'iot_process_status', NULL, 'default', 'N', '0', 'admin', '2022-01-13 15:06:03', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (139, 0, '未处理', '2', 'iot_process_status', NULL, 'default', 'N', '0', 'admin', '2022-01-13 15:06:14', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (140, 0, '已处理', '3', 'iot_process_status', NULL, 'default', 'N', '0', 'admin', '2022-01-13 15:06:24', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (141, 1, '属性上报', '1', 'iot_device_log_type', NULL, 'primary', 'N', '0', 'admin', '2022-01-13 15:10:32', 'admin', '2022-03-13 00:20:25', NULL);
INSERT INTO `sys_dict_data` VALUES (142, 3, '事件上报', '3', 'iot_device_log_type', NULL, 'danger', 'N', '0', 'admin', '2022-01-13 15:10:43', 'admin', '2022-03-13 00:21:00', NULL);
INSERT INTO `sys_dict_data` VALUES (143, 2, '功能调用', '2', 'iot_device_log_type', NULL, 'warning', 'N', '0', 'admin', '2022-01-13 15:10:55', 'admin', '2022-03-13 00:20:32', NULL);
INSERT INTO `sys_dict_data` VALUES (144, 4, '设备升级', '4', 'iot_device_log_type', NULL, 'success', 'N', '0', 'admin', '2022-01-13 15:11:08', 'admin', '2022-03-13 00:21:06', NULL);
INSERT INTO `sys_dict_data` VALUES (145, 5, '设备上线', '5', 'iot_device_log_type', NULL, 'success', 'N', '0', 'admin', '2022-01-13 15:11:23', 'admin', '2022-03-13 00:21:26', NULL);
INSERT INTO `sys_dict_data` VALUES (146, 6, '设备离线', '6', 'iot_device_log_type', NULL, 'info', 'N', '0', 'admin', '2022-01-13 15:11:32', 'admin', '2022-03-13 00:21:13', NULL);
INSERT INTO `sys_dict_data` VALUES (147, 4, '其他', '4', 'iot_network_method', NULL, 'default', 'N', '0', 'admin', '2022-01-14 02:12:49', 'admin', '2022-01-14 02:13:03', NULL);
INSERT INTO `sys_dict_data` VALUES (148, 6, '安卓/Android', '6', 'iot_device_chip', NULL, 'default', 'N', '0', 'admin', '2022-01-16 12:39:27', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (149, 7, '其他', '7', 'iot_device_chip', NULL, 'default', 'N', '0', 'admin', '2022-01-16 12:39:55', 'admin', '2022-01-16 12:40:13', NULL);
INSERT INTO `sys_dict_data` VALUES (150, 1, '小度平台', '1', 'oauth_platform', NULL, 'primary', 'N', '0', 'admin', '2022-02-07 20:29:23', 'admin', '2022-02-07 22:24:28', NULL);
INSERT INTO `sys_dict_data` VALUES (151, 2, '天猫精灵', '2', 'oauth_platform', NULL, 'danger', 'N', '0', 'admin', '2022-02-07 20:29:41', 'admin', '2022-02-07 22:23:14', NULL);
INSERT INTO `sys_dict_data` VALUES (152, 3, '小米小爱', '3', 'oauth_platform', NULL, 'success', 'N', '0', 'admin', '2022-02-07 20:30:07', 'admin', '2022-02-07 22:23:24', NULL);
INSERT INTO `sys_dict_data` VALUES (153, 4, '其他平台', '4', 'oauth_platform', NULL, 'warning', 'N', '0', 'admin', '2022-02-07 22:23:52', 'admin', '2022-02-07 22:24:02', NULL);

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 115 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (100, '物模型类别', 'iot_things_type', '0', 'admin', '2021-12-12 16:39:47', 'admin', '2021-12-15 22:49:19', '属性、动作、事件');
INSERT INTO `sys_dict_type` VALUES (101, '数据类型', 'iot_data_type', '0', 'admin', '2021-12-12 20:16:48', 'admin', '2021-12-12 20:17:54', 'integer、decimal、bool、string、enum');
INSERT INTO `sys_dict_type` VALUES (102, '是否', 'iot_yes_no', '0', 'admin', '2021-12-12 20:24:51', 'admin', '2021-12-19 15:12:35', '是、否');
INSERT INTO `sys_dict_type` VALUES (103, '产品状态', 'iot_product_status', '0', 'admin', '2021-12-19 15:00:13', '', NULL, '未发布、已发布（不能修改）');
INSERT INTO `sys_dict_type` VALUES (104, '设备类型', 'iot_device_type', '0', 'admin', '2021-12-19 15:03:06', '', NULL, '直连设备、网关子设备、网关设备');
INSERT INTO `sys_dict_type` VALUES (105, '联网方式', 'iot_network_method', '0', 'admin', '2021-12-19 15:07:12', 'admin', '2022-01-14 02:11:58', 'wifi、蜂窝(2G/3G/4G/5G)、以太网、其他');
INSERT INTO `sys_dict_type` VALUES (106, '认证方式', 'iot_vertificate_method', '0', 'admin', '2021-12-19 15:11:48', 'admin', '2021-12-19 20:56:55', '账号密码、证书、Http');
INSERT INTO `sys_dict_type` VALUES (107, '设备芯片', 'iot_device_chip', '0', 'admin', '2021-12-24 15:53:27', 'admin', '2022-01-22 00:14:23', 'ESP8266、ESP32、树莓派');
INSERT INTO `sys_dict_type` VALUES (109, '设备状态', 'iot_device_status', '0', 'admin', '2021-12-27 22:19:55', 'admin', '2021-12-27 22:20:13', '未激活、禁用、在线、离线');
INSERT INTO `sys_dict_type` VALUES (110, '是否启用', 'iot_is_enable', '0', 'admin', '2022-01-12 23:24:01', 'admin', '2022-01-12 23:24:15', '启用、禁用');
INSERT INTO `sys_dict_type` VALUES (111, '告警类型', 'iot_alert_level', '0', 'admin', '2022-01-13 14:56:44', 'admin', '2022-01-13 15:04:46', '1=提醒通知，2=轻微问题，3=严重警告');
INSERT INTO `sys_dict_type` VALUES (112, '处理状态', 'iot_process_status', '0', 'admin', '2022-01-13 15:04:06', 'admin', '2022-01-13 15:06:39', '1=不需要处理,2=未处理,3=已处理');
INSERT INTO `sys_dict_type` VALUES (113, '设备日志类型', 'iot_device_log_type', '0', 'admin', '2022-01-13 15:09:49', 'admin', '2022-03-13 00:22:43', '1=属性上报，2=调用功能,3=事件上报，4=设备升级，5=设备上线，6=设备离线');
INSERT INTO `sys_dict_type` VALUES (114, '开放平台', 'oauth_platform', '0', 'admin', '2022-02-07 20:27:48', 'admin', '2022-02-07 20:28:26', '1=小度，2=天猫精灵，3=小爱，4=其他');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2021-12-15 21:36:18', 'admin', '2022-01-29 21:48:13', '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2021-12-15 21:36:18', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1999 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------
INSERT INTO `sys_job_log` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '系统默认（无参） 总共耗时：1毫秒', '0', '', '2022-03-11 17:22:20');

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime(0) NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 111 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int(4) NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由参数',
  `is_frame` int(1) NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int(1) NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2147 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 2, 'system', NULL, '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2021-12-15 21:36:18', 'admin', '2022-02-26 00:46:20', '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 3, 'monitor', NULL, '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2021-12-15 21:36:18', 'admin', '2022-02-26 00:43:05', '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 4, 'tool', NULL, '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2021-12-15 21:36:18', 'admin', '2022-02-26 00:42:59', '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, '物美智能', 0, 5, 'http://wumei.live', NULL, '', 0, 0, 'M', '0', '0', '', 'guide', 'admin', '2021-12-15 21:36:18', 'admin', '2022-02-26 00:42:48', '若依官网地址');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2021-12-15 21:36:18', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2021-12-15 21:36:18', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2021-12-15 21:36:18', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2021-12-15 21:36:18', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2021-12-15 21:36:18', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2021-12-15 21:36:18', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2021-12-15 21:36:18', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2021-12-15 21:36:18', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2021-12-15 21:36:18', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2021-12-15 21:36:18', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2021-12-15 21:36:18', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2021-12-15 21:36:18', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2021-12-15 21:36:18', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2021-12-15 21:36:18', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '表单构建', 3, 1, 'build', 'tool/build/index', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2021-12-15 21:36:18', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (115, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2021-12-15 21:36:18', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (116, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2021-12-15 21:36:18', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2021-12-15 21:36:18', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2021-12-15 21:36:18', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1001, '用户查询', 100, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户新增', 100, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户修改', 100, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户删除', 100, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导出', 100, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '用户导入', 100, 6, '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '重置密码', 100, 7, '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色查询', 101, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色新增', 101, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色修改', 101, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色删除', 101, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '角色导出', 101, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单查询', 102, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单新增', 102, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单修改', 102, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '菜单删除', 102, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门查询', 103, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门新增', 103, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门修改', 103, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '部门删除', 103, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位查询', 104, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位新增', 104, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位修改', 104, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位删除', 104, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '岗位导出', 104, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典查询', 105, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典新增', 105, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典修改', 105, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典删除', 105, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '字典导出', 105, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数查询', 106, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数新增', 106, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数修改', 106, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数删除', 106, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '参数导出', 106, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告查询', 107, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告新增', 107, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告修改', 107, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '公告删除', 107, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作查询', 500, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '操作删除', 500, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '日志导出', 500, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录查询', 501, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '登录删除', 501, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '日志导出', 501, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 7, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 115, 1, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 115, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 115, 3, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 115, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 115, 4, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 115, 5, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '设备管理', 0, 0, 'iot', NULL, NULL, 1, 0, 'M', '0', '0', '', 'iot', 'admin', '2021-12-15 23:57:06', 'admin', '2021-12-26 23:55:54', '');
INSERT INTO `sys_menu` VALUES (2001, '产品分类', 2000, 2, 'category', 'iot/category/index', NULL, 1, 0, 'C', '0', '0', 'iot:category:list', 'category', 'admin', '2021-12-16 00:40:02', 'admin', '2021-12-26 23:56:20', '产品分类菜单');
INSERT INTO `sys_menu` VALUES (2002, '产品分类查询', 2001, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:category:query', '#', 'admin', '2021-12-16 00:40:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2003, '产品分类新增', 2001, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:category:add', '#', 'admin', '2021-12-16 00:40:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2004, '产品分类修改', 2001, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:category:edit', '#', 'admin', '2021-12-16 00:40:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2005, '产品分类删除', 2001, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:category:remove', '#', 'admin', '2021-12-16 00:40:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2006, '产品分类导出', 2001, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:category:export', '#', 'admin', '2021-12-16 00:40:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2007, '设备管理', 2000, 6, 'device', 'iot/device/index', NULL, 1, 0, 'C', '0', '0', 'iot:device:list', 'device', 'admin', '2021-12-16 00:40:12', 'admin', '2022-01-08 15:47:14', '设备菜单');
INSERT INTO `sys_menu` VALUES (2008, '设备查询', 2007, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:device:query', '#', 'admin', '2021-12-16 00:40:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2009, '设备新增', 2007, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:device:add', '#', 'admin', '2021-12-16 00:40:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2010, '设备修改', 2007, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:device:edit', '#', 'admin', '2021-12-16 00:40:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2011, '设备删除', 2007, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:device:remove', '#', 'admin', '2021-12-16 00:40:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2012, '设备导出', 2007, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:device:export', '#', 'admin', '2021-12-16 00:40:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2013, '产品固件', 2000, 4, 'firmware', 'iot/firmware/index', NULL, 1, 0, 'C', '0', '0', 'iot:firmware:list', 'firmware', 'admin', '2021-12-16 00:40:20', 'admin', '2021-12-26 23:56:42', '产品固件菜单');
INSERT INTO `sys_menu` VALUES (2014, '产品固件查询', 2013, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:firmware:query', '#', 'admin', '2021-12-16 00:40:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2015, '产品固件新增', 2013, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:firmware:add', '#', 'admin', '2021-12-16 00:40:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2016, '产品固件修改', 2013, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:firmware:edit', '#', 'admin', '2021-12-16 00:40:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2017, '产品固件删除', 2013, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:firmware:remove', '#', 'admin', '2021-12-16 00:40:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2018, '产品固件导出', 2013, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:firmware:export', '#', 'admin', '2021-12-16 00:40:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2019, '设备分组', 2000, 5, 'group', 'iot/group/index', NULL, 1, 0, 'C', '0', '0', 'iot:group:list', 'group', 'admin', '2021-12-16 00:40:31', 'admin', '2021-12-26 23:56:54', '设备分组菜单');
INSERT INTO `sys_menu` VALUES (2020, '设备分组查询', 2019, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:group:query', '#', 'admin', '2021-12-16 00:40:31', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2021, '设备分组新增', 2019, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:group:add', '#', 'admin', '2021-12-16 00:40:31', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2022, '设备分组修改', 2019, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:group:edit', '#', 'admin', '2021-12-16 00:40:31', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2023, '设备分组删除', 2019, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:group:remove', '#', 'admin', '2021-12-16 00:40:31', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2024, '设备分组导出', 2019, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:group:export', '#', 'admin', '2021-12-16 00:40:31', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2043, '产品管理', 2000, 3, 'product', 'iot/product/index', NULL, 1, 0, 'C', '0', '0', 'iot:product:list', 'product', 'admin', '2021-12-16 00:41:18', 'admin', '2021-12-26 23:58:44', '产品菜单');
INSERT INTO `sys_menu` VALUES (2044, '产品查询', 2043, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:product:query', '#', 'admin', '2021-12-16 00:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2045, '产品新增', 2043, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:product:add', '#', 'admin', '2021-12-16 00:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2046, '产品修改', 2043, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:product:edit', '#', 'admin', '2021-12-16 00:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2047, '产品删除', 2043, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:product:remove', '#', 'admin', '2021-12-16 00:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2048, '产品导出', 2043, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:product:export', '#', 'admin', '2021-12-16 00:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2049, '通用物模型', 2000, 1, 'template', 'iot/template/index', NULL, 1, 0, 'C', '0', '0', 'iot:template:list', 'model', 'admin', '2021-12-16 00:41:28', 'admin', '2021-12-26 23:56:09', '通用物模型菜单');
INSERT INTO `sys_menu` VALUES (2050, '通用物模型查询', 2049, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:template:query', '#', 'admin', '2021-12-16 00:41:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2051, '通用物模型新增', 2049, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:template:add', '#', 'admin', '2021-12-16 00:41:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2052, '通用物模型修改', 2049, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:template:edit', '#', 'admin', '2021-12-16 00:41:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2053, '通用物模型删除', 2049, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:template:remove', '#', 'admin', '2021-12-16 00:41:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2054, '通用物模型导出', 2049, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:template:export', '#', 'admin', '2021-12-16 00:41:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2067, '设备告警', 2000, 7, 'alertLog', 'iot/alertLog/index', NULL, 1, 0, 'C', '1', '0', 'iot:alertLog:list', 'alert', 'admin', '2022-01-13 17:16:15', 'admin', '2022-03-01 17:48:57', '设备告警菜单');
INSERT INTO `sys_menu` VALUES (2068, '设备告警查询', 2067, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:alertLog:query', '#', 'admin', '2022-01-13 17:16:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2069, '设备告警新增', 2067, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:alertLog:add', '#', 'admin', '2022-01-13 17:16:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2070, '设备告警修改', 2067, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:alertLog:edit', '#', 'admin', '2022-01-13 17:16:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2071, '设备告警删除', 2067, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:alertLog:remove', '#', 'admin', '2022-01-13 17:16:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2072, '设备告警导出', 2067, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:alertLog:export', '#', 'admin', '2022-01-13 17:16:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2085, '场景联动', 2000, 8, 'scene', 'iot/scene/index', NULL, 1, 0, 'C', '1', '0', 'iot:scene:list', 'scene', 'admin', '2022-01-13 17:16:45', 'admin', '2022-03-25 22:30:50', '场景联动菜单');
INSERT INTO `sys_menu` VALUES (2086, '场景联动查询', 2085, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:scene:query', '#', 'admin', '2022-01-13 17:16:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2087, '场景联动新增', 2085, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:scene:add', '#', 'admin', '2022-01-13 17:16:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2088, '场景联动修改', 2085, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:scene:edit', '#', 'admin', '2022-01-13 17:16:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2089, '场景联动删除', 2085, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:scene:remove', '#', 'admin', '2022-01-13 17:16:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2090, '场景联动导出', 2085, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:scene:export', '#', 'admin', '2022-01-13 17:16:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2098, '云云对接', 2000, 9, 'clientDetails', 'iot/clientDetails/index', NULL, 1, 0, 'C', '1', '0', 'iot:clientDetails:list', 'cloud', 'admin', '2022-02-07 22:08:58', 'admin', '2022-03-01 17:48:37', '云云对接菜单');
INSERT INTO `sys_menu` VALUES (2099, '云云对接查询', 2098, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:clientDetails:query', '#', 'admin', '2022-02-07 22:08:59', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2100, '云云对接新增', 2098, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:clientDetails:add', '#', 'admin', '2022-02-07 22:08:59', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2101, '云云对接修改', 2098, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:clientDetails:edit', '#', 'admin', '2022-02-07 22:08:59', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2102, '云云对接删除', 2098, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:clientDetails:remove', '#', 'admin', '2022-02-07 22:08:59', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2103, '云云对接导出', 2098, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:clientDetails:export', '#', 'admin', '2022-02-07 22:08:59', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2104, 'EMQ管理', 0, 1, 'emqx', NULL, NULL, 1, 0, 'M', '0', '0', '', 'mq', 'admin', '2022-02-26 00:42:12', 'admin', '2022-03-04 14:08:55', '');
INSERT INTO `sys_menu` VALUES (2105, '客户端', 2104, 1, 'client', 'iot/emqx/client', NULL, 1, 0, 'C', '0', '0', 'monitor:online:list', 'client', 'admin', '2022-02-26 00:45:39', 'admin', '2022-03-04 14:09:23', '');
INSERT INTO `sys_menu` VALUES (2106, '消息主题', 2104, 3, 'topic', 'iot/emqx/topic', NULL, 1, 0, 'C', '0', '0', 'monitor:online:list', 'topic', 'admin', '2022-02-27 16:31:17', 'admin', '2022-03-04 14:10:00', '');
INSERT INTO `sys_menu` VALUES (2107, '消息订阅', 2104, 4, 'subscribe', 'iot/emqx/subscribe', NULL, 1, 0, 'C', '0', '0', 'monitor:online:list', 'subscribe', 'admin', '2022-02-27 16:32:21', 'admin', '2022-03-04 14:10:17', '');
INSERT INTO `sys_menu` VALUES (2108, '插件管理', 2104, 5, 'plugin', 'iot/emqx/plugin', NULL, 1, 0, 'C', '0', '0', 'monitor:online:list', 'plugin', 'admin', '2022-02-27 19:10:40', 'admin', '2022-03-04 14:10:28', '');
INSERT INTO `sys_menu` VALUES (2109, '监听器', 2104, 2, 'listener', 'iot/emqx/listener', NULL, 1, 0, 'C', '0', '0', 'monitor:online:list', 'listener', 'admin', '2022-02-27 19:52:08', 'admin', '2022-03-04 14:09:44', '');
INSERT INTO `sys_menu` VALUES (2110, 'EMQ操作', 2104, 6, '', NULL, NULL, 1, 0, 'F', '0', '0', 'monitor:online:edit', '#', 'admin', '2022-03-09 16:58:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2111, '资源', 2104, 9, 'resource', 'iot/emqx/resource', NULL, 1, 0, 'C', '0', '0', 'monitor:online:list', 'build', 'admin', '2022-04-07 14:16:53', 'admin', '2022-04-07 14:20:31', '');
INSERT INTO `sys_menu` VALUES (2112, '规则引擎', 2104, 8, 'rule', 'iot/emqx/rule', NULL, 1, 0, 'C', '0', '0', 'monitor:online:list', 'build', 'admin', '2022-04-07 14:19:37', 'admin', '2022-04-07 14:20:50', '');
INSERT INTO `sys_menu` VALUES (2123, '新闻分类', 1, 1, 'newsCategory', 'iot/newsCategory/index', NULL, 1, 0, 'C', '0', '0', 'iot:newsCategory:list', 'category', 'admin', '2022-04-11 16:47:27', 'admin', '2022-04-11 17:56:07', '新闻分类菜单');
INSERT INTO `sys_menu` VALUES (2124, '新闻分类查询', 2123, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:newsCategory:query', '#', 'admin', '2022-04-11 16:47:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2125, '新闻分类新增', 2123, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:newsCategory:add', '#', 'admin', '2022-04-11 16:47:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2126, '新闻分类修改', 2123, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:newsCategory:edit', '#', 'admin', '2022-04-11 16:47:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2127, '新闻分类删除', 2123, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:newsCategory:remove', '#', 'admin', '2022-04-11 16:47:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2128, '新闻分类导出', 2123, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:newsCategory:export', '#', 'admin', '2022-04-11 16:47:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2129, '新闻资讯', 1, 1, 'news', 'iot/news/index', NULL, 1, 0, 'C', '0', '0', 'iot:news:list', 'documentation', 'admin', '2022-04-11 16:47:46', 'admin', '2022-04-11 17:58:46', '新闻资讯菜单');
INSERT INTO `sys_menu` VALUES (2130, '新闻资讯查询', 2129, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:news:query', '#', 'admin', '2022-04-11 16:47:46', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2131, '新闻资讯新增', 2129, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:news:add', '#', 'admin', '2022-04-11 16:47:46', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2132, '新闻资讯修改', 2129, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:news:edit', '#', 'admin', '2022-04-11 16:47:46', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2133, '新闻资讯删除', 2129, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:news:remove', '#', 'admin', '2022-04-11 16:47:46', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2134, '新闻资讯导出', 2129, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:news:export', '#', 'admin', '2022-04-11 16:47:46', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2136, '产品授权码查询', 2043, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:authorize:query', '#', 'admin', '2022-04-11 17:17:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2137, '产品授权码新增', 2043, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:authorize:add', '#', 'admin', '2022-04-11 17:17:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2138, '产品授权码修改', 2043, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:authorize:edit', '#', 'admin', '2022-04-11 17:17:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2139, '产品授权码删除', 2043, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:authorize:remove', '#', 'admin', '2022-04-11 17:17:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2140, '产品授权码导出', 2043, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:authorize:export', '#', 'admin', '2022-04-11 17:17:53', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2021-03-15 wumei-smart新版本发布了', '2', 0x3C703E3C696D67207372633D222F6465762D6170692F70726F66696C652F75706C6F61642F323032322F30342F31332F38353538626130362D323730612D343639632D626239622D6636353165666631356135632E706E67223EE696B0E78988E69CACE58685E5AEB93C2F703E, '0', 'admin', '2021-12-15 21:36:18', 'admin', '2022-04-13 23:48:20', '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2021-03151 wumei-smart系统凌晨2点-4点维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2021-12-15 21:36:18', '', NULL, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int(2) NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int(1) NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int(1) NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime(0) NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`oper_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 234 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int(4) NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2021-12-15 21:36:18', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(4) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 104 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '设备租户', 'tenant', 2, '5', 1, 1, '0', '0', 'admin', '2021-12-16 16:41:30', 'admin', '2022-04-15 16:15:55', '不能删除，管理产品和设备的用户分配该权限');
INSERT INTO `sys_role` VALUES (3, '普通用户', 'common', 3, '5', 1, 1, '0', '0', 'admin', '2021-12-15 21:36:18', 'admin', '2022-04-15 17:05:01', '普通角色，不能删除，设备的最终用户，只能管理设备');
INSERT INTO `sys_role` VALUES (4, '游客', 'visitor', 4, '5', 1, 1, '0', '0', 'admin', '2021-12-16 16:44:30', 'admin', '2022-03-09 17:03:25', '只能查询系统数据');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 2000);
INSERT INTO `sys_role_menu` VALUES (2, 2001);
INSERT INTO `sys_role_menu` VALUES (2, 2002);
INSERT INTO `sys_role_menu` VALUES (2, 2003);
INSERT INTO `sys_role_menu` VALUES (2, 2004);
INSERT INTO `sys_role_menu` VALUES (2, 2005);
INSERT INTO `sys_role_menu` VALUES (2, 2006);
INSERT INTO `sys_role_menu` VALUES (2, 2007);
INSERT INTO `sys_role_menu` VALUES (2, 2008);
INSERT INTO `sys_role_menu` VALUES (2, 2009);
INSERT INTO `sys_role_menu` VALUES (2, 2010);
INSERT INTO `sys_role_menu` VALUES (2, 2011);
INSERT INTO `sys_role_menu` VALUES (2, 2012);
INSERT INTO `sys_role_menu` VALUES (2, 2013);
INSERT INTO `sys_role_menu` VALUES (2, 2014);
INSERT INTO `sys_role_menu` VALUES (2, 2015);
INSERT INTO `sys_role_menu` VALUES (2, 2016);
INSERT INTO `sys_role_menu` VALUES (2, 2017);
INSERT INTO `sys_role_menu` VALUES (2, 2018);
INSERT INTO `sys_role_menu` VALUES (2, 2019);
INSERT INTO `sys_role_menu` VALUES (2, 2020);
INSERT INTO `sys_role_menu` VALUES (2, 2021);
INSERT INTO `sys_role_menu` VALUES (2, 2022);
INSERT INTO `sys_role_menu` VALUES (2, 2023);
INSERT INTO `sys_role_menu` VALUES (2, 2024);
INSERT INTO `sys_role_menu` VALUES (2, 2043);
INSERT INTO `sys_role_menu` VALUES (2, 2044);
INSERT INTO `sys_role_menu` VALUES (2, 2045);
INSERT INTO `sys_role_menu` VALUES (2, 2046);
INSERT INTO `sys_role_menu` VALUES (2, 2047);
INSERT INTO `sys_role_menu` VALUES (2, 2048);
INSERT INTO `sys_role_menu` VALUES (2, 2049);
INSERT INTO `sys_role_menu` VALUES (2, 2050);
INSERT INTO `sys_role_menu` VALUES (2, 2051);
INSERT INTO `sys_role_menu` VALUES (2, 2052);
INSERT INTO `sys_role_menu` VALUES (2, 2053);
INSERT INTO `sys_role_menu` VALUES (2, 2054);
INSERT INTO `sys_role_menu` VALUES (2, 2067);
INSERT INTO `sys_role_menu` VALUES (2, 2068);
INSERT INTO `sys_role_menu` VALUES (2, 2069);
INSERT INTO `sys_role_menu` VALUES (2, 2070);
INSERT INTO `sys_role_menu` VALUES (2, 2071);
INSERT INTO `sys_role_menu` VALUES (2, 2072);
INSERT INTO `sys_role_menu` VALUES (2, 2085);
INSERT INTO `sys_role_menu` VALUES (2, 2086);
INSERT INTO `sys_role_menu` VALUES (2, 2087);
INSERT INTO `sys_role_menu` VALUES (2, 2088);
INSERT INTO `sys_role_menu` VALUES (2, 2089);
INSERT INTO `sys_role_menu` VALUES (2, 2090);
INSERT INTO `sys_role_menu` VALUES (2, 2098);
INSERT INTO `sys_role_menu` VALUES (2, 2099);
INSERT INTO `sys_role_menu` VALUES (2, 2100);
INSERT INTO `sys_role_menu` VALUES (2, 2101);
INSERT INTO `sys_role_menu` VALUES (2, 2102);
INSERT INTO `sys_role_menu` VALUES (2, 2103);
INSERT INTO `sys_role_menu` VALUES (2, 2136);
INSERT INTO `sys_role_menu` VALUES (2, 2137);
INSERT INTO `sys_role_menu` VALUES (2, 2138);
INSERT INTO `sys_role_menu` VALUES (2, 2139);
INSERT INTO `sys_role_menu` VALUES (2, 2140);
INSERT INTO `sys_role_menu` VALUES (3, 2000);
INSERT INTO `sys_role_menu` VALUES (3, 2007);
INSERT INTO `sys_role_menu` VALUES (3, 2008);
INSERT INTO `sys_role_menu` VALUES (3, 2009);
INSERT INTO `sys_role_menu` VALUES (3, 2010);
INSERT INTO `sys_role_menu` VALUES (3, 2011);
INSERT INTO `sys_role_menu` VALUES (3, 2012);
INSERT INTO `sys_role_menu` VALUES (3, 2019);
INSERT INTO `sys_role_menu` VALUES (3, 2020);
INSERT INTO `sys_role_menu` VALUES (3, 2021);
INSERT INTO `sys_role_menu` VALUES (3, 2022);
INSERT INTO `sys_role_menu` VALUES (3, 2023);
INSERT INTO `sys_role_menu` VALUES (3, 2024);
INSERT INTO `sys_role_menu` VALUES (3, 2067);
INSERT INTO `sys_role_menu` VALUES (3, 2068);
INSERT INTO `sys_role_menu` VALUES (3, 2069);
INSERT INTO `sys_role_menu` VALUES (3, 2070);
INSERT INTO `sys_role_menu` VALUES (3, 2071);
INSERT INTO `sys_role_menu` VALUES (3, 2072);
INSERT INTO `sys_role_menu` VALUES (3, 2085);
INSERT INTO `sys_role_menu` VALUES (3, 2086);
INSERT INTO `sys_role_menu` VALUES (3, 2087);
INSERT INTO `sys_role_menu` VALUES (3, 2088);
INSERT INTO `sys_role_menu` VALUES (3, 2089);
INSERT INTO `sys_role_menu` VALUES (3, 2090);
INSERT INTO `sys_role_menu` VALUES (4, 1);
INSERT INTO `sys_role_menu` VALUES (4, 2);
INSERT INTO `sys_role_menu` VALUES (4, 3);
INSERT INTO `sys_role_menu` VALUES (4, 4);
INSERT INTO `sys_role_menu` VALUES (4, 100);
INSERT INTO `sys_role_menu` VALUES (4, 101);
INSERT INTO `sys_role_menu` VALUES (4, 102);
INSERT INTO `sys_role_menu` VALUES (4, 103);
INSERT INTO `sys_role_menu` VALUES (4, 104);
INSERT INTO `sys_role_menu` VALUES (4, 105);
INSERT INTO `sys_role_menu` VALUES (4, 106);
INSERT INTO `sys_role_menu` VALUES (4, 107);
INSERT INTO `sys_role_menu` VALUES (4, 108);
INSERT INTO `sys_role_menu` VALUES (4, 109);
INSERT INTO `sys_role_menu` VALUES (4, 110);
INSERT INTO `sys_role_menu` VALUES (4, 111);
INSERT INTO `sys_role_menu` VALUES (4, 112);
INSERT INTO `sys_role_menu` VALUES (4, 113);
INSERT INTO `sys_role_menu` VALUES (4, 114);
INSERT INTO `sys_role_menu` VALUES (4, 115);
INSERT INTO `sys_role_menu` VALUES (4, 116);
INSERT INTO `sys_role_menu` VALUES (4, 500);
INSERT INTO `sys_role_menu` VALUES (4, 501);
INSERT INTO `sys_role_menu` VALUES (4, 1001);
INSERT INTO `sys_role_menu` VALUES (4, 1008);
INSERT INTO `sys_role_menu` VALUES (4, 1013);
INSERT INTO `sys_role_menu` VALUES (4, 1017);
INSERT INTO `sys_role_menu` VALUES (4, 1021);
INSERT INTO `sys_role_menu` VALUES (4, 1026);
INSERT INTO `sys_role_menu` VALUES (4, 1031);
INSERT INTO `sys_role_menu` VALUES (4, 1036);
INSERT INTO `sys_role_menu` VALUES (4, 1040);
INSERT INTO `sys_role_menu` VALUES (4, 1043);
INSERT INTO `sys_role_menu` VALUES (4, 1046);
INSERT INTO `sys_role_menu` VALUES (4, 1049);
INSERT INTO `sys_role_menu` VALUES (4, 1055);
INSERT INTO `sys_role_menu` VALUES (4, 2000);
INSERT INTO `sys_role_menu` VALUES (4, 2001);
INSERT INTO `sys_role_menu` VALUES (4, 2002);
INSERT INTO `sys_role_menu` VALUES (4, 2003);
INSERT INTO `sys_role_menu` VALUES (4, 2004);
INSERT INTO `sys_role_menu` VALUES (4, 2007);
INSERT INTO `sys_role_menu` VALUES (4, 2008);
INSERT INTO `sys_role_menu` VALUES (4, 2009);
INSERT INTO `sys_role_menu` VALUES (4, 2010);
INSERT INTO `sys_role_menu` VALUES (4, 2013);
INSERT INTO `sys_role_menu` VALUES (4, 2014);
INSERT INTO `sys_role_menu` VALUES (4, 2015);
INSERT INTO `sys_role_menu` VALUES (4, 2016);
INSERT INTO `sys_role_menu` VALUES (4, 2019);
INSERT INTO `sys_role_menu` VALUES (4, 2020);
INSERT INTO `sys_role_menu` VALUES (4, 2021);
INSERT INTO `sys_role_menu` VALUES (4, 2022);
INSERT INTO `sys_role_menu` VALUES (4, 2043);
INSERT INTO `sys_role_menu` VALUES (4, 2044);
INSERT INTO `sys_role_menu` VALUES (4, 2045);
INSERT INTO `sys_role_menu` VALUES (4, 2046);
INSERT INTO `sys_role_menu` VALUES (4, 2049);
INSERT INTO `sys_role_menu` VALUES (4, 2050);
INSERT INTO `sys_role_menu` VALUES (4, 2051);
INSERT INTO `sys_role_menu` VALUES (4, 2052);
INSERT INTO `sys_role_menu` VALUES (4, 2067);
INSERT INTO `sys_role_menu` VALUES (4, 2068);
INSERT INTO `sys_role_menu` VALUES (4, 2069);
INSERT INTO `sys_role_menu` VALUES (4, 2070);
INSERT INTO `sys_role_menu` VALUES (4, 2085);
INSERT INTO `sys_role_menu` VALUES (4, 2086);
INSERT INTO `sys_role_menu` VALUES (4, 2087);
INSERT INTO `sys_role_menu` VALUES (4, 2088);
INSERT INTO `sys_role_menu` VALUES (4, 2098);
INSERT INTO `sys_role_menu` VALUES (4, 2099);
INSERT INTO `sys_role_menu` VALUES (4, 2100);
INSERT INTO `sys_role_menu` VALUES (4, 2101);
INSERT INTO `sys_role_menu` VALUES (4, 2104);
INSERT INTO `sys_role_menu` VALUES (4, 2105);
INSERT INTO `sys_role_menu` VALUES (4, 2106);
INSERT INTO `sys_role_menu` VALUES (4, 2107);
INSERT INTO `sys_role_menu` VALUES (4, 2108);
INSERT INTO `sys_role_menu` VALUES (4, 2109);
INSERT INTO `sys_role_menu` VALUES (100, 2000);
INSERT INTO `sys_role_menu` VALUES (100, 2001);
INSERT INTO `sys_role_menu` VALUES (100, 2002);
INSERT INTO `sys_role_menu` VALUES (100, 2003);
INSERT INTO `sys_role_menu` VALUES (100, 2004);
INSERT INTO `sys_role_menu` VALUES (100, 2005);
INSERT INTO `sys_role_menu` VALUES (100, 2006);
INSERT INTO `sys_role_menu` VALUES (100, 2007);
INSERT INTO `sys_role_menu` VALUES (100, 2008);
INSERT INTO `sys_role_menu` VALUES (100, 2009);
INSERT INTO `sys_role_menu` VALUES (100, 2010);
INSERT INTO `sys_role_menu` VALUES (100, 2011);
INSERT INTO `sys_role_menu` VALUES (100, 2012);
INSERT INTO `sys_role_menu` VALUES (100, 2013);
INSERT INTO `sys_role_menu` VALUES (100, 2014);
INSERT INTO `sys_role_menu` VALUES (100, 2015);
INSERT INTO `sys_role_menu` VALUES (100, 2016);
INSERT INTO `sys_role_menu` VALUES (100, 2017);
INSERT INTO `sys_role_menu` VALUES (100, 2018);
INSERT INTO `sys_role_menu` VALUES (100, 2019);
INSERT INTO `sys_role_menu` VALUES (100, 2020);
INSERT INTO `sys_role_menu` VALUES (100, 2021);
INSERT INTO `sys_role_menu` VALUES (100, 2022);
INSERT INTO `sys_role_menu` VALUES (100, 2023);
INSERT INTO `sys_role_menu` VALUES (100, 2024);
INSERT INTO `sys_role_menu` VALUES (100, 2031);
INSERT INTO `sys_role_menu` VALUES (100, 2032);
INSERT INTO `sys_role_menu` VALUES (100, 2033);
INSERT INTO `sys_role_menu` VALUES (100, 2034);
INSERT INTO `sys_role_menu` VALUES (100, 2035);
INSERT INTO `sys_role_menu` VALUES (100, 2036);
INSERT INTO `sys_role_menu` VALUES (100, 2037);
INSERT INTO `sys_role_menu` VALUES (100, 2038);
INSERT INTO `sys_role_menu` VALUES (100, 2039);
INSERT INTO `sys_role_menu` VALUES (100, 2040);
INSERT INTO `sys_role_menu` VALUES (100, 2041);
INSERT INTO `sys_role_menu` VALUES (100, 2042);
INSERT INTO `sys_role_menu` VALUES (100, 2043);
INSERT INTO `sys_role_menu` VALUES (100, 2044);
INSERT INTO `sys_role_menu` VALUES (100, 2045);
INSERT INTO `sys_role_menu` VALUES (100, 2046);
INSERT INTO `sys_role_menu` VALUES (100, 2047);
INSERT INTO `sys_role_menu` VALUES (100, 2048);
INSERT INTO `sys_role_menu` VALUES (100, 2049);
INSERT INTO `sys_role_menu` VALUES (100, 2050);
INSERT INTO `sys_role_menu` VALUES (100, 2051);
INSERT INTO `sys_role_menu` VALUES (100, 2052);
INSERT INTO `sys_role_menu` VALUES (100, 2053);
INSERT INTO `sys_role_menu` VALUES (100, 2054);
INSERT INTO `sys_role_menu` VALUES (100, 2061);
INSERT INTO `sys_role_menu` VALUES (100, 2062);
INSERT INTO `sys_role_menu` VALUES (100, 2063);
INSERT INTO `sys_role_menu` VALUES (100, 2064);
INSERT INTO `sys_role_menu` VALUES (100, 2065);
INSERT INTO `sys_role_menu` VALUES (100, 2066);
INSERT INTO `sys_role_menu` VALUES (101, 1);
INSERT INTO `sys_role_menu` VALUES (101, 2);
INSERT INTO `sys_role_menu` VALUES (101, 100);
INSERT INTO `sys_role_menu` VALUES (101, 101);
INSERT INTO `sys_role_menu` VALUES (101, 102);
INSERT INTO `sys_role_menu` VALUES (101, 103);
INSERT INTO `sys_role_menu` VALUES (101, 104);
INSERT INTO `sys_role_menu` VALUES (101, 107);
INSERT INTO `sys_role_menu` VALUES (101, 109);
INSERT INTO `sys_role_menu` VALUES (101, 110);
INSERT INTO `sys_role_menu` VALUES (101, 1001);
INSERT INTO `sys_role_menu` VALUES (101, 1008);
INSERT INTO `sys_role_menu` VALUES (101, 1013);
INSERT INTO `sys_role_menu` VALUES (101, 1017);
INSERT INTO `sys_role_menu` VALUES (101, 1021);
INSERT INTO `sys_role_menu` VALUES (101, 1036);
INSERT INTO `sys_role_menu` VALUES (101, 1046);
INSERT INTO `sys_role_menu` VALUES (101, 1049);
INSERT INTO `sys_role_menu` VALUES (101, 2000);
INSERT INTO `sys_role_menu` VALUES (101, 2001);
INSERT INTO `sys_role_menu` VALUES (101, 2002);
INSERT INTO `sys_role_menu` VALUES (101, 2007);
INSERT INTO `sys_role_menu` VALUES (101, 2008);
INSERT INTO `sys_role_menu` VALUES (101, 2013);
INSERT INTO `sys_role_menu` VALUES (101, 2014);
INSERT INTO `sys_role_menu` VALUES (101, 2019);
INSERT INTO `sys_role_menu` VALUES (101, 2020);
INSERT INTO `sys_role_menu` VALUES (101, 2031);
INSERT INTO `sys_role_menu` VALUES (101, 2032);
INSERT INTO `sys_role_menu` VALUES (101, 2037);
INSERT INTO `sys_role_menu` VALUES (101, 2038);
INSERT INTO `sys_role_menu` VALUES (101, 2043);
INSERT INTO `sys_role_menu` VALUES (101, 2044);
INSERT INTO `sys_role_menu` VALUES (101, 2049);
INSERT INTO `sys_role_menu` VALUES (101, 2050);
INSERT INTO `sys_role_menu` VALUES (101, 2061);
INSERT INTO `sys_role_menu` VALUES (101, 2062);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(20) NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime(0) NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 125 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '物美智能管理员', '00', '164770707@qq.com', '15888888888', '0', '', '$2a$10$0Duw0QB6s7YnQEaNSdSVWeXHMmSa090pG15ZXpf.CQEzEhgxyr7IO', '0', '0', '127.0.0.1', '2022-04-22 00:50:41', 'admin', '2021-12-15 21:36:18', '', '2022-04-22 00:50:41', '管理员');
INSERT INTO `sys_user` VALUES (118, 100, 'wumei', '游客账号', '00', '', '', '0', '', '$2a$10$kKeZptrTnSlm0fencX4U2eq.QiaukDs.DckiUsMCwVTxh0IS2LRQ.', '0', '0', '127.0.0.1', '2022-03-15 23:25:38', 'admin', '2022-03-09 16:49:19', 'admin', '2022-03-15 23:25:38', NULL);
INSERT INTO `sys_user` VALUES (121, 100, 'wumei-tenant-one', '物美租户壹', '00', '', '15888888880', '0', '', '$2a$10$BAWId9C2Nrcwklzl1Ikoau4iqL8XRGvfRjq6Wl.PXWpzwAw0sXMdK', '0', '0', '127.0.0.1', '2022-04-16 12:37:50', 'admin', '2022-04-15 16:21:25', '', '2022-04-16 12:37:49', NULL);
INSERT INTO `sys_user` VALUES (122, 100, 'wumei-tenant-two', '物美租户贰', '00', '', '15988888880', '0', '', '$2a$10$1zMlbW7hGpzA59gpzWGO/ObeASziQ296evjMjHrYdZnxKBLU4WUum', '0', '0', '127.0.0.1', '2022-04-16 12:48:57', 'admin', '2022-04-15 16:22:08', '', '2022-04-16 12:48:57', NULL);
INSERT INTO `sys_user` VALUES (123, 100, 'wumei-user-one', '物美用户壹', '00', '', '13988888880', '0', '', '$2a$10$691RJMXZ9HM4sgNTExLPfO5Nw6J6cWgCvcoF9V.jKMnPk5o/8c9VS', '0', '0', '127.0.0.1', '2022-04-16 12:42:29', 'admin', '2022-04-15 16:22:37', 'admin', '2022-04-16 12:42:29', NULL);
INSERT INTO `sys_user` VALUES (124, 100, 'wumei-user-two', '物美用户贰', '00', '', '13866666660', '0', '', '$2a$10$x3rM39rewwbi7ayvriGMEOKUHoPCqcL2CYXPLTJRCWYPVvykFIYJq', '0', '0', '127.0.0.1', '2022-04-15 17:02:25', 'admin', '2022-04-15 16:23:13', '', '2022-04-15 17:02:24', NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (118, 4);
INSERT INTO `sys_user_role` VALUES (121, 2);
INSERT INTO `sys_user_role` VALUES (122, 2);
INSERT INTO `sys_user_role` VALUES (123, 3);
INSERT INTO `sys_user_role` VALUES (124, 3);

SET FOREIGN_KEY_CHECKS = 1;
