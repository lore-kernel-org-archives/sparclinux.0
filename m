From: Borislav Petkov <bp@alien8.de>
Date: Wed, 30 Mar 2016 11:42:47 +0000
Subject: [PATCH 4/5] sparc/defconfigs: Remove CONFIG_IPV6_PRIVACY
Message-Id: <1459338168-29334-5-git-send-email-bp@alien8.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1459338168-29334-1-git-send-email-bp@alien8.de>
In-Reply-To: <1459338168-29334-1-git-send-email-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: sparclinux@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Option is long gone, see

  5d9efa7ee99e ("ipv6: Remove privacy config option.")

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/configs/sparc32_defconfig | 1 -
 arch/sparc/configs/sparc64_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/sparc/configs/sparc32_defconfig b/arch/sparc/configs/sparc32_defconfig
index fb23fd6b186a..c74d3701ad68 100644
--- a/arch/sparc/configs/sparc32_defconfig
+++ b/arch/sparc/configs/sparc32_defconfig
@@ -24,7 +24,6 @@ CONFIG_INET_AH=y
 CONFIG_INET_ESP=y
 CONFIG_INET_IPCOMP=y
 # CONFIG_INET_LRO is not set
-CONFIG_IPV6_PRIVACY=y
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
 CONFIG_INET6_IPCOMP=m
diff --git a/arch/sparc/configs/sparc64_defconfig b/arch/sparc/configs/sparc64_defconfig
index 04920ab8e292..3583d676a916 100644
--- a/arch/sparc/configs/sparc64_defconfig
+++ b/arch/sparc/configs/sparc64_defconfig
@@ -48,7 +48,6 @@ CONFIG_SYN_COOKIES=y
 CONFIG_INET_AH=y
 CONFIG_INET_ESP=y
 CONFIG_INET_IPCOMP=y
-CONFIG_IPV6_PRIVACY=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_IPV6_ROUTE_INFO=y
 CONFIG_IPV6_OPTIMISTIC_DAD=y
-- 
2.7.3

