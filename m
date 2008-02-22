From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 22 Feb 2008 20:32:29 +0000
Subject: [PATCH][SPARC64] fix section mismatchs from dr_cpu_data
Message-Id: <20080222203229.GE7154@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

[SPARC64] fix section mismatchs from dr_cpu_data

Fix following warnings:
WARNING: vmlinux.o(.text+0x4b258): Section mismatch in reference from the function dr_cpu_data() to the function .devinit.text:mdesc_fill_in_cpu_data()
WARNING: vmlinux.o(.text+0x4b290): Section mismatch in reference from the function dr_cpu_data() to the function .cpuinit.text:cpu_up()

mdesc_fill_in_cpu_data() is only used during early init and for
cpu hotplug so the __cpuinit annotation is the correct choice.
We have the call chain:
dr_cpu_data() => dr_cpu_configure() => mdesc_fill_in_cpu_data()

dr_cpu_data() is used only during early init and for cpu
hotplug. So annotating them all __cpuinit solves the
section mismatch and should be correct.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: David S. Miller <davem@davemloft.net>
---

Please review before you apply.
I am not 100% sure if my assumptions are correct.

	Sam

diff --git a/arch/sparc64/kernel/ds.c b/arch/sparc64/kernel/ds.c
index eeb5a2f..bd76482 100644
--- a/arch/sparc64/kernel/ds.c
+++ b/arch/sparc64/kernel/ds.c
@@ -525,10 +525,10 @@ static void dr_cpu_mark(struct ds_data *resp, int cpu, int ncpus,
 	}
 }
 
-static int dr_cpu_configure(struct ds_info *dp,
-			    struct ds_cap_state *cp,
-			    u64 req_num,
-			    cpumask_t *mask)
+static int __cpuinit dr_cpu_configure(struct ds_info *dp,
+				      struct ds_cap_state *cp,
+				      u64 req_num,
+				      cpumask_t *mask)
 {
 	struct ds_data *resp;
 	int resp_len, ncpus, cpu;
@@ -623,9 +623,9 @@ static int dr_cpu_unconfigure(struct ds_info *dp,
 	return 0;
 }
 
-static void dr_cpu_data(struct ds_info *dp,
-			struct ds_cap_state *cp,
-			void *buf, int len)
+static void __cpuinit dr_cpu_data(struct ds_info *dp,
+				  struct ds_cap_state *cp,
+				  void *buf, int len)
 {
 	struct ds_data *data = buf;
 	struct dr_cpu_tag *tag = (struct dr_cpu_tag *) (data + 1);
diff --git a/arch/sparc64/kernel/mdesc.c b/arch/sparc64/kernel/mdesc.c
index 856659b..9100835 100644
--- a/arch/sparc64/kernel/mdesc.c
+++ b/arch/sparc64/kernel/mdesc.c
@@ -758,7 +758,7 @@ static void __devinit get_mondo_data(struct mdesc_handle *hp, u64 mp,
 	get_one_mondo_bits(val, &tb->nonresum_qmask, 2);
 }
 
-void __devinit mdesc_fill_in_cpu_data(cpumask_t mask)
+void __cpuinit mdesc_fill_in_cpu_data(cpumask_t mask)
 {
 	struct mdesc_handle *hp = mdesc_grab();
 	u64 mp;
