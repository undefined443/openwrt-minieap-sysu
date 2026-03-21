include $(TOPDIR)/rules.mk

PKG_NAME:=minieap
PKG_VERSION:=0.94.0
#PKG_RELEASE:=1
PKG_MAINTAINER:=Xiao Li <xiaoli3397@gmail.com>
PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_DIR:=$(BUILD_DIR)/minieap-$(PKG_VERSION)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/undefined443/minieap-sysu.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Extensible 802.1x client with Ruijie v3 (v4) plugin
	MAINTAINER:=undefined443
	URL:=https://github.com/undefined443/minieap-sysu
endef

define Package/$(PKG_NAME)/description
	This is an EAP client that implements the SYSU custom EAP-MD5-Challenge algorithm.
	It supports plug-in to modify the standard data package to authenticate the special server.
endef

define Package/$(PKG_NAME)/conffiles
	/etc/minieap.conf
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/minieap $(1)/usr/sbin/

	$(INSTALL_DIR) $(1)/lib/netifd/proto
	$(INSTALL_BIN) ./files/minieap.sh $(1)/lib/netifd/proto/
	$(INSTALL_BIN) ./files/minieap.script $(1)/lib/netifd/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
