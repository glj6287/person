CREATE TABLE app_user (
	id INT NOT NULL AUTO_INCREMENT COMMENT '主键，自增长',
	mobile VARCHAR (15) NOT NULL COMMENT '手机号码',
	PASSWORD VARCHAR (100) NOT NULL COMMENT '密码',
	salt VARCHAR (60) NOT NULL COMMENT '加密向量',
	realName VARCHAR (45) COMMENT '真实姓名',
	idCard VARCHAR (20) COMMENT '身份证号码',
	bankCard VARCHAR (32) COMMENT '银行卡号',
	ylbUserId VARCHAR (16) COMMENT '永利宝用户id',
	state TINYINT (1) NOT NULL COMMENT '状态1启用0停用',
	regtime BIGINT (13) NOT NULL COMMENT '注册时间',
	isCertification TINYINT (1) DEFAULT '0' NOT NULL COMMENT '是否实名认证(0: 未认证 1:已认证)',
	updatetime BIGINT (13) NOT NULL COMMENT '更新时间',
	createStatus TINYINT (1) COMMENT '开户绑卡状态（0未开户1已开户）',
	payPwdStatus TINYINT (1) COMMENT '支付密码状态（0未设置1已设置）',
	jxAccount VARCHAR (32) COMMENT '江西存管平台分配的账号',
	PRIMARY KEY (id),
	CONSTRAINT id_UNIQUE UNIQUE (id),
	CONSTRAINT uniq_mobile UNIQUE (mobile)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT = 'APP登录用户';

CREATE TABLE backend_permission (
	id INT NOT NULL AUTO_INCREMENT COMMENT '主键id',
	permission VARCHAR (45) NOT NULL COMMENT '权限',
	permissionName VARCHAR (45) NOT NULL COMMENT '权限名称',
	url VARCHAR (200) COMMENT '权限对应的链接地址',
	moduleid INT NOT NULL COMMENT '模块id',
	updateby INT COMMENT '更新人',
	updatetime INT COMMENT '更新时间',
	PRIMARY KEY (id),
	CONSTRAINT id_UNIQUE UNIQUE (id),
	INDEX fk_moduleid_idx (moduleid)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT = '权限表';

CREATE TABLE backend_role (
	id INT NOT NULL AUTO_INCREMENT COMMENT '主键id',
	role VARCHAR (45) NOT NULL COMMENT '角色',
	roleDescription VARCHAR (45) COMMENT '角色描述',
	roleState TINYINT (1) DEFAULT '1' NOT NULL COMMENT '状态1:启用 0:停用',
	updateby INT COMMENT '更新人',
	updatetime INT COMMENT '更新时间',
	PRIMARY KEY (id),
	CONSTRAINT id_UNIQUE UNIQUE (id)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT = '角色表';

CREATE TABLE backend_role_permission (
	roleid INT NOT NULL COMMENT '角色id',
	permissionid INT NOT NULL COMMENT '权限id',
	PRIMARY KEY (roleid, permissionid),
	INDEX fk_permissionid_idx (permissionid)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT = '角色权限关联表';

CREATE TABLE backend_user (
	id INT NOT NULL AUTO_INCREMENT COMMENT '主键，自增长',
	username VARCHAR (45) NOT NULL COMMENT '用户名',
	salt VARCHAR (60) NOT NULL COMMENT '加密向量',
	PASSWORD VARCHAR (100) NOT NULL COMMENT '密码',
	realName VARCHAR (45) NOT NULL COMMENT '真实姓名',
	mobile VARCHAR (15) NOT NULL COMMENT '手机号码',
	email VARCHAR (100) COMMENT '邮箱',
	sex TINYINT (1) COMMENT '性别1男2女',
	institutionId INT COMMENT '机构id',
	state TINYINT (1) NOT NULL COMMENT '状态1启用0停用',
	regtime INT NOT NULL COMMENT '注册时间',
	updatetime INT NOT NULL COMMENT '更新时间',
	PRIMARY KEY (id),
	CONSTRAINT id_UNIQUE UNIQUE (id)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT = '后台用户';

CREATE TABLE backend_user_role (
	userid INT NOT NULL COMMENT '用户id',
	roleid INT NOT NULL COMMENT '角色id',
	PRIMARY KEY (userid, roleid)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT = '后台用户角色关联表';

CREATE TABLE debtcycle (
	id INT NOT NULL AUTO_INCREMENT,
	institutionId INT NOT NULL COMMENT '机构ID',
	count INT DEFAULT '0' NOT NULL COMMENT '大债券协议期数',
	PRIMARY KEY (id)
) ENGINE = INNODB DEFAULT CHARSET = utf8;

CREATE TABLE debterror (
	id INT NOT NULL AUTO_INCREMENT,
	requisitionId INT NOT NULL COMMENT '如果发布失败需要插入的申请单ID',
	type TINYINT NOT NULL COMMENT '0（推送的），1（已放款）',
	PRIMARY KEY (id)
) ENGINE = INNODB DEFAULT CHARSET = utf8;

CREATE TABLE debts (
	id INT NOT NULL AUTO_INCREMENT,
	debtsName VARCHAR (50) NOT NULL COMMENT '债权名称',
	debtsAmount INT NOT NULL COMMENT '金额',
	debtsCycle INT (3) NOT NULL COMMENT '债权周期',
	publishTime BIGINT (13) COMMENT '债权发布时间',
	publishStatus TINYINT (1) DEFAULT '0' NOT NULL COMMENT '债全发布状态0未发布 1已发布 2已放款',
	institutionId INT NOT NULL COMMENT '机构id',
	debtsZipFile VARCHAR (512) COMMENT '债权附件',
	creator INT NOT NULL COMMENT '创建人',
	createtime BIGINT (13) NOT NULL COMMENT '创建时间',
	updateby INT NOT NULL COMMENT '修改人',
	updatetime BIGINT (13) NOT NULL COMMENT '修改时间',
	PRIMARY KEY (id),
	INDEX ind_updatetime (updatetime),
	INDEX ind_debtsname (debtsName),
	INDEX ind_publishStatus (publishStatus)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT = '债权';

CREATE TABLE institution (
	id INT NOT NULL AUTO_INCREMENT COMMENT '机构id',
	NAME VARCHAR (100) NOT NULL COMMENT '机构名称',
	CODE VARCHAR (20) NOT NULL COMMENT '机构简码',
	appid VARCHAR (32) NOT NULL COMMENT '机构接口对接申请令牌使用的身份标识',
	secret VARCHAR (64) NOT NULL COMMENT '机构接口对接申请令牌使用的密码',
	address VARCHAR (50) COMMENT '机构地址',
	mobile VARCHAR (16) COMMENT '联系电话',
	contactPerson VARCHAR (50) COMMENT '联系人',
	STATUS TINYINT (1) DEFAULT '1' NOT NULL COMMENT '状态1启用0关闭',
	auth_key VARCHAR (50) COMMENT '连接接口的auth_key',
	token VARCHAR (1000) COMMENT '连接接口的token',
	creditMoney INT COMMENT '机构每天授信额度，-1不受限制',
	lenderUid VARCHAR (50) COMMENT '出借人',
	bailUid VARCHAR (50) COMMENT '担保人',
	openingBank VARCHAR (20) COMMENT '开户行',
	institutionType VARCHAR (5) COMMENT '机构类型',
	bankAccount VARCHAR (22) COMMENT '银行卡号',
	monthRate DOUBLE COMMENT '月综合费率',
	paymentType INT (4) COMMENT '还款方式 ',
	PRIMARY KEY (id),
	CONSTRAINT uniq_appid UNIQUE (appid),
	INDEX ind_status (STATUS)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT = '机构';

CREATE TABLE log_validatecode (
	id INT NOT NULL AUTO_INCREMENT,
	mobile VARCHAR (20) NOT NULL,
	validatecode VARCHAR (6) NOT NULL,
	sendtime datetime NOT NULL,
	PRIMARY KEY (id),
	INDEX ind_mobile (mobile)
) ENGINE = INNODB DEFAULT CHARSET = utf8;

CREATE TABLE module (
	id INT NOT NULL AUTO_INCREMENT COMMENT '主键',
	moduleName VARCHAR (45) NOT NULL COMMENT '模块名称',
	PRIMARY KEY (id),
	CONSTRAINT id_UNIQUE UNIQUE (id)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT = '模块表';

CREATE TABLE requisition (
	id INT NOT NULL AUTO_INCREMENT COMMENT '申请单ID',
	userId INT COMMENT 'M端用户ID',
	userName VARCHAR (100) NOT NULL COMMENT '姓名',
	idNum VARCHAR (50) NOT NULL COMMENT '身份证号',
	projectNo VARCHAR (50) NOT NULL COMMENT '项目编号',
	cycle INT (3) NOT NULL COMMENT '期限',
	startDate BIGINT (13) COMMENT '起息日。如2016-12-12',
	endDate BIGINT (13) COMMENT '到期日。如2016-12-12',
	amount INT NOT NULL COMMENT '申请金额。单位：元',
	orderId VARCHAR (50) COMMENT '订单号',
	appDate BIGINT (13) NOT NULL COMMENT '申请时间。如2016-12-12',
	loanContract VARCHAR (512) COMMENT '借款合同。如:http://xx.xx.xxx/lafielw.pdf',
	riskReport VARCHAR (512) COMMENT '风控报告。如:http://xx.xx.xxx/lafielw.pdf',
	phone VARCHAR (12) NOT NULL COMMENT '手机号码',
	bankCard VARCHAR (32) COMMENT '银行卡号',
	auditingStatus INT (2) DEFAULT '0' NOT NULL COMMENT '审核状态（0永利宝未审核，1永利宝审核通过，2永利宝审核不通过，3已分配, 4放款中，5合作商未审核 6合作商审核不通过7还款中8所有还款已结清9未发布10债权已上线11债权存管处理中12债权存管处理成功13债权存管处理失败14债权已募集满15债权放款处理中16债权放款成功17债权放款失败18提现处理中19提现成功20提现失败21债权正常还款22债权逾期未还款23债权逾期还款24债权放款划账到机构处理中25债权放款划账到机构处理成功26债权放款划账到机构处理失败27取消申请单申请28申请单完结）',
	institutionId INT NOT NULL COMMENT '机构id',
	debtId INT COMMENT '债权id',
	banksPhoto VARCHAR (512) COMMENT '银行流水附件截图',
	zipfile VARCHAR (512) COMMENT '所有的附件打包URL',
	debtOrderId INT COMMENT '放款时需要的ID',
	ylbUserId VARCHAR (16) COMMENT '永利宝用户id',
	errorInfo VARCHAR (1000) COMMENT '发布失败的错误信息',
	monthRate DECIMAL (10, 3) UNSIGNED COMMENT '月利率',
	creator INT DEFAULT '0' NOT NULL COMMENT '创建人',
	createtime BIGINT (13) NOT NULL COMMENT '创建时间',
	updateby INT DEFAULT '0' NOT NULL COMMENT '修改人',
	updatetime BIGINT (13) NOT NULL COMMENT '修改时间',
	loanReason VARCHAR (500) COMMENT '放款失败原因',
	loanStatus INT (2) DEFAULT '0' COMMENT '财务放款状态。新申请时状态为0，财务放款后状态为1，继续申请时状态改为2',
	PRIMARY KEY (id),
	CONSTRAINT uniq_proins UNIQUE (projectNo, institutionId),
	INDEX ind_idNum (idNum),
	INDEX ind_userId (userId),
	INDEX ind_institutionid (institutionId),
	INDEX ind_cycle (cycle),
	INDEX ind_auditingstatus (auditingStatus),
	INDEX ind_debtId (debtId),
	INDEX ind_appDate (appDate)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT = '业务申请单表';

CREATE TABLE requisition_count (
	queryDate date NOT NULL COMMENT '查询日期',
	institutionId INT NOT NULL COMMENT '机构id',
	processingAmount INT DEFAULT '0' NOT NULL COMMENT '审核中金额',
	processingOrderNums INT DEFAULT '0' NOT NULL COMMENT '审核中申请单笔数',
	loanAmount INT DEFAULT '0' NOT NULL COMMENT '放款金额',
	loanOrderNums INT DEFAULT '0' NOT NULL COMMENT '已放款申请单数',
	totalLoanAmount INT DEFAULT '0' NOT NULL COMMENT '累计已放款金额',
	totalLoanOrderNums INT DEFAULT '0' NOT NULL COMMENT '累计已放款笔数',
	PRIMARY KEY (queryDate, institutionId)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT = '分期汇总统计表';

CREATE TABLE sl_credit_limit_config (
	id INT NOT NULL AUTO_INCREMENT COMMENT '合作机构ID',
	institutionId INT DEFAULT '0' COMMENT '机构ID',
	initialAmount INT (10) DEFAULT '0' NOT NULL COMMENT '初始额度',
	maxAmount INT DEFAULT '0' COMMENT '个人贷款最大额度',
	usedAmount DECIMAL (12, 2) DEFAULT '0.00' COMMENT '已使用额度',
	creator INT DEFAULT '0' NOT NULL COMMENT '创建者',
	createtime BIGINT (13) COMMENT '创建时间',
	updateby INT DEFAULT '0' NOT NULL COMMENT '修改者',
	updatetime BIGINT (13) COMMENT '修改时间',
	PRIMARY KEY (id)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT = '资金额度配置表';

CREATE TABLE sl_interface_result (
	id INT NOT NULL AUTO_INCREMENT,
	userFundLogId INT NOT NULL COMMENT '资金记录ID',
	requisitionId INT COMMENT '申请单ID',
	requestInterFaceUrl VARCHAR (500) COMMENT '请求永利宝接口地址',
	requestInterFaceParam VARCHAR (1000) COMMENT '请求永利宝参数',
	type INT (1) COMMENT '类型(1:充值 2:还款)',
	returnCode INT (1) DEFAULT '0' COMMENT '接口返回状态码(0:处理中 1:成功 2:失败)',
	remark VARCHAR (500) COMMENT '描述接口消息',
	retryCount INT (1) DEFAULT '0' COMMENT '重试次数',
	creator INT DEFAULT '0' NOT NULL COMMENT '创建者',
	createtime BIGINT (13),
	PRIMARY KEY (id)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT = '调用永利宝接口返回结果';

CREATE TABLE sl_rate_rules (
	id INT NOT NULL AUTO_INCREMENT,
	institutionId INT NOT NULL COMMENT '机构ID',
	period INT NOT NULL COMMENT '期数',
	monthRate DECIMAL (10, 3) NOT NULL COMMENT '月利率',
	serviceRate DECIMAL (10, 2) DEFAULT '0.00' COMMENT '服务费率',
	creator INT DEFAULT '0' NOT NULL COMMENT '创建者',
	createtime BIGINT (13) COMMENT '创建时间',
	PRIMARY KEY (id, period)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT = '分期计费规则表';

CREATE TABLE sl_repayment_plan (
	id INT NOT NULL AUTO_INCREMENT,
	requisitionId INT NOT NULL COMMENT '申请单号',
	stage INT (3) DEFAULT '0' NOT NULL COMMENT '期次',
	planRepayDate BIGINT (13) NOT NULL COMMENT '计划还款日期',
	planRepayAmount DECIMAL (12, 2) DEFAULT '0.00' NOT NULL COMMENT '计划还款金额',
	actualRepayDate BIGINT (13) COMMENT '实际还款日期',
	actualRepayAmount DECIMAL (12, 2) DEFAULT '0.00' COMMENT '实际还款金额',
	repayStatus INT (1) DEFAULT '0' COMMENT '还款状态(1:已结清；0:未结清;2:处理中)',
	exceedStatus INT (1) DEFAULT '0' COMMENT '是否逾期(0:未逾期 1:已逾期)',
	repayType INT (1) DEFAULT '0' NOT NULL COMMENT '还款来源(0:个人还款  1:企业代还款)',
	isRecentRepay INT (1) DEFAULT '0' COMMENT '是否是最近一次还款(0:否 1:是)',
	creator INT DEFAULT '0' NOT NULL COMMENT '创建者',
	createtime BIGINT (13) COMMENT '创建时间',
	updateby INT DEFAULT '0' NOT NULL COMMENT '更新者',
	updatetime BIGINT (13) COMMENT '更新时间',
	PRIMARY KEY (id),
	INDEX idx_requisitionId (requisitionId),
	INDEX ind_isRecentRepay (isRecentRepay)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT = '还款计划表';

CREATE TABLE sl_req_consume_log (
	requisitionId INT NOT NULL COMMENT '申请单ID',
	creator INT DEFAULT '0' NOT NULL COMMENT '创建者',
	createtime BIGINT (13) COMMENT '创建时间',
	PRIMARY KEY (requisitionId)
) ENGINE = MyISAM DEFAULT CHARSET = utf8 COMMENT = '申请单确认消费记录';

CREATE TABLE sl_req_message_log (
	id INT NOT NULL AUTO_INCREMENT,
	requisitionId INT NOT NULL COMMENT '申请单ID',
	creator INT DEFAULT '0' NOT NULL COMMENT '创建人',
	createtime BIGINT (13) COMMENT '创建时间',
	PRIMARY KEY (id)
) ENGINE = MyISAM DEFAULT CHARSET = utf8 COMMENT = '申请单已读消息记录';

CREATE TABLE sl_user_fund_log (
	id INT NOT NULL AUTO_INCREMENT,
	userId INT NOT NULL COMMENT '用户ID',
	amount DECIMAL (12, 2) DEFAULT '0.00' NOT NULL COMMENT '金额',
	type INT (3) DEFAULT '0' NOT NULL COMMENT '资金类型(101: 充值 201: 还款)',
	returnCode INT (1) DEFAULT '0' COMMENT '接口返回状态码(0:处理中 1:成功 2:失败)',
	repaymentPlanId INT COMMENT '还款计划ID',
	repayType INT (1) DEFAULT '0' COMMENT '还款来源(0:个人还款  1:企业代还款)',
	remark VARCHAR (1000) COMMENT '描述',
	creator INT DEFAULT '0' NOT NULL COMMENT '创建者',
	createtime BIGINT (13) NOT NULL COMMENT '创建时间',
	PRIMARY KEY (id),
	INDEX idx_userId (userId)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT = '用户资金记录表';

CREATE TABLE t_black_list (
	id INT NOT NULL AUTO_INCREMENT COMMENT '黑名单id',
	infoId INT COMMENT '征信信息ID',
	bl_type VARCHAR (4) COMMENT '黑名单类型  1:90天以上未结清借款,2:不良中介,3:虚假资料,4:信息冒用,5:团伙诈骗,6:代偿,7:法院被执行人信息',
	bl_time VARCHAR (10) COMMENT '发生时间格式=yyyy-MM-dd',
	bl_amount DECIMAL (12, 2) COMMENT '涉及金额',
	bl_reason VARCHAR (500) COMMENT '原因说明',
	bl_memberName VARCHAR (64) COMMENT '提供机构（名称）',
	creator INT COMMENT '创建人',
	createtime BIGINT (13) COMMENT '创建时间',
	updateby INT COMMENT '修改人',
	updatetime BIGINT (13) COMMENT '修改时间',
	PRIMARY KEY (id)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT = '黑名单历史表';

CREATE TABLE t_credit_info_xwjr (
	id INT NOT NULL AUTO_INCREMENT COMMENT '信息id',
	userId INT COMMENT '用户信息Id',
	memberType VARCHAR (4) COMMENT '01:P2P机构,02:小贷公司,03:保险公司,99:其他',
	la_orgCount_0_6 BIGINT COMMENT '收到借款申请机构总数（最近6个月）',
	la_orgCount_6_12 BIGINT COMMENT '收到借款申请机构总数（最近6~12个月）',
	la_orgCount_12_24 BIGINT COMMENT '收到借款申请机构总数（最近12~24个月）',
	la_approved_0_6 BIGINT COMMENT '借款申请通过总笔数（最近6个月）',
	la_approved_6_12 BIGINT COMMENT '借款申请通过总笔数（最近6~12个月）',
	la_approved_12_24 BIGINT COMMENT '借款申请通过总笔数（最近12~24个月）',
	la_rejected_0_6 BIGINT COMMENT '借款申请拒绝总笔数（最近6个月）',
	la_rejected_6_12 BIGINT COMMENT '借款申请拒绝总笔数（最近6~12个月）',
	la_rejected_12_24 BIGINT COMMENT '借款申请拒绝总笔数（最近12~24个月）',
	la_lastRejectTime VARCHAR (12) COMMENT '最近一次拒绝申请时间(格式：yyyy-MM-dd)',
	lb_loanTotal BIGINT COMMENT '借款成功总笔数',
	lb_uncleared BIGINT COMMENT '未结清正常总笔数',
	lb_unclearedAmount DECIMAL (12, 2) COMMENT '正常待还总额',
	lb_overdueUncleared BIGINT COMMENT '未结清逾期总笔数',
	lb_overdueUnclearedAmount DECIMAL (12, 2) COMMENT '未结清逾期总额',
	lb_normalLoanOrgCount BIGINT COMMENT '正常还款机构数',
	lb_overdueUnclearedMaxTime INT COMMENT '未结清贷款最长逾期时间（天）',
	lb_overdueCleared BIGINT COMMENT '已结清逾期笔数',
	lb_overdueClearedAmount DECIMAL (12, 2) COMMENT '已结清逾期总额',
	lb_overdueMaxTime INT COMMENT '历史最长逾期时间（天）',
	rl_loanOriginationTime VARCHAR (12) COMMENT '最近一次贷款放款时间（yyyy-MM-dd）',
	rl_loanOriginationAmount DECIMAL (12, 2) COMMENT '最近一笔贷款放款金额',
	rl_overdueClearedAmount DECIMAL (12, 2) COMMENT '最近一笔当前逾期金额',
	rl_overdueAmount DECIMAL (12, 2) COMMENT '最近一笔贷款逾期总额',
	rl_overdueMaxTime INT COMMENT '最近一笔贷款最长逾期时间（天）',
	nl_loanOriginationOrgCount BIGINT COMMENT 'n个月内放款机构总数',
	nl_loanRejectedOrgCount BIGINT COMMENT 'n个月内拒绝贷款申请机构总数',
	nl_loanOriginationAmount DECIMAL (12, 2) COMMENT 'n个月内各机构最近一笔贷款累计放款金额',
	nl_overdueClearedAmount DECIMAL (12, 2) COMMENT 'n个月内各机构最近一笔贷款当前累计逾期总额',
	nl_overdueAmount DECIMAL (12, 2) COMMENT 'n个月内各机构最近一笔贷款累计逾期总额',
	nl_overdueOrgCount BIGINT COMMENT 'n个月内各机构最近一笔贷款发生逾期的机构总数',
	nl_overdueMaxTime VARCHAR (8) COMMENT 'n个月内各机构最近一笔贷款最长逾期时间（天）',
	nl_queryOrgCount BIGINT (8) COMMENT 'n个月内查询机构总数',
	ol_nameUnmatchedOrgCount BIGINT COMMENT '姓名不一致的机构数',
	ol_totalMemberCount INT COMMENT '应反馈机构数',
	ol_feedbackMemberCount INT COMMENT '实际反馈机构数',
	bl_type VARCHAR (4) COMMENT '黑名单类型  1:90天以上未结清借款,2:不良中介,3:虚假资料,4:信息冒用,5:团伙诈骗,6:代偿,7:法院被执行人信息',
	bl_time VARCHAR (10) COMMENT '发生时间格式=yyyy-MM-dd',
	bl_amount DECIMAL (12, 2) COMMENT '涉及金额',
	bl_reason VARCHAR (500) COMMENT '原因说明',
	bl_memberName VARCHAR (64) COMMENT '提供机构（名称）',
	creator INT COMMENT '创建人',
	createtime BIGINT (13) COMMENT '创建时间',
	updateby INT COMMENT '修改人',
	updatetime BIGINT (13) COMMENT '修改时间',
	black_id INT COMMENT '黑名单ID',
	PRIMARY KEY (id)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT = '小微金融征信信息表';

CREATE TABLE t_credit_institution (
	id INT NOT NULL COMMENT '机构ID',
	NAME VARCHAR (100) COMMENT '机构名称',
	CODE VARCHAR (20) COMMENT '机构简码',
	appid VARCHAR (32) COMMENT '机构接口对接申请令牌使用的身份标识',
	secret VARCHAR (64) COMMENT '机构接口对接申请令牌使用的密码',
	address VARCHAR (50) COMMENT '机构地址',
	mobile VARCHAR (16) COMMENT '联系电话',
	contactPerson VARCHAR (50) COMMENT '联系人',
	STATUS TINYINT (1) COMMENT '状态',
	creator INT COMMENT '创建人',
	createtime BIGINT (13) COMMENT '创建时间',
	updateby INT COMMENT '修改人',
	updatetime BIGINT (13) COMMENT '修改时间',
	PRIMARY KEY (id)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT = '征信机构信息';

CREATE TABLE t_credit_user (
	id INT NOT NULL,
	mobile VARCHAR (16) COMMENT '手机号码',
	realName VARCHAR (45) COMMENT '真实姓名',
	idCard VARCHAR (20) COMMENT '身份证号码',
	blankCard VARCHAR (32) COMMENT '银行卡号',
	ylbUserId VARCHAR (16) COMMENT '永利宝用户id',
	state TINYINT (1) COMMENT '状态',
	regtime BIGINT (13) COMMENT '注册时间',
	isCertification TINYINT (1) COMMENT '是否实名',
	jxAccount VARCHAR (32) COMMENT '江西存管平台分配的账号',
	createStatus TINYINT (1) COMMENT '开户绑卡状态',
	payPwdStatus TINYINT (1) COMMENT '支付密码设置状态',
	creator INT COMMENT '创建人',
	createtime BIGINT (13) COMMENT '创建时间',
	updateby INT COMMENT '修改人',
	updatetime BIGINT (13) COMMENT '修改时间',
	PRIMARY KEY (id)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT = '用户信息';

CREATE TABLE t_credit_user_record (
	id INT NOT NULL AUTO_INCREMENT COMMENT 'id',
	userId INT COMMENT '用户信息Id',
	institutionId INT (12) COMMENT '机构Id',
	period INT (2) COMMENT '查询结果汇总的时间范围,单位:月',
	STATUS VARCHAR (5) COMMENT '返回状态',
	message VARCHAR (200) COMMENT '查询结构消息',
	tid VARCHAR (64) COMMENT '查询凭证',
	infoId INT COMMENT '征信信息ID',
	creator INT COMMENT '创建人',
	createtime BIGINT (13) COMMENT '创建时间',
	updateby INT COMMENT '修改人',
	updatetime BIGINT (13) COMMENT '修改时间',
	PRIMARY KEY (id)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT = '用户征信查询履历';

ALTER TABLE backend_permission ADD FOREIGN KEY (moduleid) REFERENCES module (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE backend_role_permission ADD FOREIGN KEY (permissionid) REFERENCES backend_permission (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE backend_role_permission ADD FOREIGN KEY (roleid) REFERENCES backend_role (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

