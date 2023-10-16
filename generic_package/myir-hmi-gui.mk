################################################################################
#
# myir-hmi-v2.0 for weidongshan@qq.com
#
################################################################################
		  			 		  						  					  				 	   		  	  	 	  
MYIR_HMI_GUI_VERSION = 509b96ab2466326df2ea3fe673edcabd899cc96d        #软件版本
MYIR_HMI_GUI_SITE = https://gitee.com/weidongshan/Qtmxapp-desktop.git  #下载位置
MYIR_HMI_GUI_SITE_METHOD = git                                         #下载方法
MYIR_HMI_GUI_DEPENDENCIES = qt5multimedia qt5base qt5declarative       #依赖项
MYIR_HMI_GUI_LICENSE = GPL-3.0                                         #许可证
		  			 		  						  					  				 	   		  	  	 	  
define MYIR_HMI_GUI_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_MAKE_ENV) $(QT5_QMAKE))
endef
		  			 		  						  					  				 	   		  	  	 	  
define MYIR_HMI_GUI_BUILD_CMDS                   #构建命令
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

#To the target directory, $(TARGET_DIR), which is what will be the target root
#filesystem.
#<pkg>_INSTALL_TARGET, defaults to YES. If YES, then <pkg>_INSTALL_TARGET_CMDS
#will be called.		  			 		  						  					  				 	   		  	  	 	  
define MYIR_HMI_GUI_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/mxapp2 \
		$(TARGET_DIR)/usr/bin/mxapp2  \
	mkdir -p $(TARGET_DIR)/usr/share/fonts; \
	mkdir -p $(TARGET_DIR)/usr/share/myir; \
	mkdir -p $(TARGET_DIR)/usr/share/ecg; \
	
	$(INSTALL) -D -m 0755 $(@D)/Samplelibrary/fonts/ttf/msyh.ttc \
		$(TARGET_DIR)/usr/lib/fonts/msyh.ttc \		
	$(INSTALL) -D -m 0755 $(@D)/Samplelibrary/fonts/ttf//msyh.ttc \
		$(TARGET_DIR)/usr/share/fonts/msyh.ttc
	
endef

#They can do so using the following variables, which contain a list of shell
#commands.
#	<pkg>_INSTALL_INIT_SYSV
#	<pkg>_INSTALL_INIT_SYSTEMD
#	<pkg>_INSTALL_INIT_OPENRC
#Buildroot will execute the appropriate <pkg>_INSTALL_INIT_xyz commands of all
#enabled packages depending on the selected init system.
#LIBFOO_INSTALL_INIT_SYSV、 LIBFOO_INSTALL_INIT_OPENRC和 LIBFOO_INSTALL_INIT_SYSTEMD
#列出为 SystemV-like init系统（ busybox、 sysvinit等）、 openrc或 systemd units安装init脚本时需执行的操作。这些命令仅在安装了相关的初始化系统后才运行（ 例如
#如果在配置中选择systemd作为初始化系统，则仅运行LIBFOO_INSTALL_INIT_SYSTEMD）。
#etc/init.d/rcS 默认会在/etc/init.d 目录下查找所有以‘S’开头的脚本，然后依次执行这些脚本，也就是开机自启动
define MYIR_HMI_GUI_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D  package/myir-hmi-gui/S99myirhmi2 \
		$(TARGET_DIR)/etc/init.d/S99myirhmi2
endef

define MYIR_HMI_GUI_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 755 package/myir-hmi-gui/start.sh \
		$(TARGET_DIR)/usr/bin/start.sh \
	$(INSTALL) -D -m 644 package/myir-hmi-gui/myir.service \
		$(TARGET_DIR)/usr/lib/systemd/system/myir.service
endef
		  			 		  						  					  				 	   		  	  	 	  
$(eval $(generic-package))
