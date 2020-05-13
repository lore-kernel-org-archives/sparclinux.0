From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Wed, 13 May 2020 21:43:47 +0000
Subject: [PATCH 07/11] sparc64: constify sysrq_key_op
Message-Id: <20200513214351.2138580-7-emil.l.velikov@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200513214351.2138580-1-emil.l.velikov@gmail.com>
In-Reply-To: <20200513214351.2138580-1-emil.l.velikov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, emil.l.velikov@gmail.com, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

With earlier commits, the API no longer discards the const-ness of the
sysrq_key_op. As such we can add the notation.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
Please keep me in the CC list, as I'm not subscribed to the list.

IMHO it would be better if this gets merged this via the tty tree.
---
 arch/sparc/kernel/process_64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index 4282116e28e7..423011e60982 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -313,7 +313,7 @@ static void sysrq_handle_globreg(int key)
 	trigger_all_cpu_backtrace();
 }
 
-static struct sysrq_key_op sparc_globalreg_op = {
+static const struct sysrq_key_op sparc_globalreg_op = {
 	.handler	= sysrq_handle_globreg,
 	.help_msg	= "global-regs(y)",
 	.action_msg	= "Show Global CPU Regs",
@@ -388,7 +388,7 @@ static void sysrq_handle_globpmu(int key)
 	pmu_snapshot_all_cpus();
 }
 
-static struct sysrq_key_op sparc_globalpmu_op = {
+static const struct sysrq_key_op sparc_globalpmu_op = {
 	.handler	= sysrq_handle_globpmu,
 	.help_msg	= "global-pmu(x)",
 	.action_msg	= "Show Global PMU Regs",
-- 
2.25.1
