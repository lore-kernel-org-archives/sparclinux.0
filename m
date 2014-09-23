From: Michal Marek <mmarek@suse.cz>
Date: Tue, 23 Sep 2014 15:44:04 +0000
Subject: [PATCH 5/5] sparc: Set CONFIG_NET=y in defconfigs
Message-Id: <1411487044-14071-5-git-send-email-mmarek@suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <54218AEF.5090200@suse.cz>
 <1411487044-14071-1-git-send-email-mmarek@suse.cz>
In-Reply-To: <1411487044-14071-1-git-send-email-mmarek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sfr@canb.auug.org.au, rdunlap@infradead.org, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, sparclinux@vger.kernel.org

Commit 5d6be6a5 ("scsi_netlink : Make SCSI_NETLINK dependent on NET
instead of selecting NET") removed what happened to be the only instance
of 'select NET'. Defconfigs that were relying on the select now lack
networking support.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Michal Marek <mmarek@suse.cz>
---
 arch/sparc/configs/sparc64_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/configs/sparc64_defconfig b/arch/sparc/configs/sparc64_defconfig
index 9d8521b..6b68f12 100644
--- a/arch/sparc/configs/sparc64_defconfig
+++ b/arch/sparc/configs/sparc64_defconfig
@@ -29,6 +29,7 @@ CONFIG_PCI=y
 CONFIG_PCI_MSI=y
 CONFIG_SUN_OPENPROMFS=m
 CONFIG_BINFMT_MISC=m
+CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_XFRM_USER=m
-- 
1.8.4.5

