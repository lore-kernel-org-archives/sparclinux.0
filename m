From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Date: Thu, 07 May 2020 19:23:02 +0000
Subject: [PATCH] sparc64: Replace zero-length array with flexible-array
Message-Id: <20200507192302.GA16402@embeddedor>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 arch/sparc/kernel/cpumap.c |    2 +-
 arch/sparc/kernel/ds.c     |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/kernel/cpumap.c b/arch/sparc/kernel/cpumap.c
index 1cb62bfeaa1f..f07ea88a83af 100644
--- a/arch/sparc/kernel/cpumap.c
+++ b/arch/sparc/kernel/cpumap.c
@@ -50,7 +50,7 @@ struct cpuinfo_tree {
 
 	/* Offsets into nodes[] for each level of the tree */
 	struct cpuinfo_level level[CPUINFO_LVL_MAX];
-	struct cpuinfo_node  nodes[0];
+	struct cpuinfo_node  nodes[];
 };
 
 
diff --git a/arch/sparc/kernel/ds.c b/arch/sparc/kernel/ds.c
index 75232cbd58bf..522e5b51050c 100644
--- a/arch/sparc/kernel/ds.c
+++ b/arch/sparc/kernel/ds.c
@@ -87,7 +87,7 @@ struct ds_reg_req {
 	__u64			handle;
 	__u16			major;
 	__u16			minor;
-	char			svc_id[0];
+	char			svc_id[];
 };
 
 struct ds_reg_ack {
@@ -701,12 +701,12 @@ struct ds_var_hdr {
 
 struct ds_var_set_msg {
 	struct ds_var_hdr		hdr;
-	char				name_and_value[0];
+	char				name_and_value[];
 };
 
 struct ds_var_delete_msg {
 	struct ds_var_hdr		hdr;
-	char				name[0];
+	char				name[];
 };
 
 struct ds_var_resp {
@@ -989,7 +989,7 @@ struct ds_queue_entry {
 	struct ds_info			*dp;
 	int				req_len;
 	int				__pad;
-	u64				req[0];
+	u64				req[];
 };
 
 static void process_ds_work(void)
