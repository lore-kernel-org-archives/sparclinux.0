From: Jag Raman <jag.raman@oracle.com>
Date: Fri, 23 Jun 2017 18:58:37 +0000
Subject: [PATCH v2 09/12] sparc64: check if a client is allowed to register for MDESC notifications
Message-Id: <9f88c78ab49c64e5f824af1064b09601eae477f9.1498238657.git.jag.raman@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Check if a client is supported, by comparing against a whitelist, to
register for notifications from Machine Description (MDESC)

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 arch/sparc/kernel/mdesc.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index 04b7626..f795ee0 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -284,9 +284,26 @@ void mdesc_release(struct mdesc_handle *hp)
 
 void mdesc_register_notifier(struct mdesc_notifier_client *client)
 {
+	bool supported = false;
 	u64 node;
+	int i;
 
 	mutex_lock(&mdesc_mutex);
+
+	/* check to see if the node is supported for registration */
+	for (i = 0; md_node_ops_table[i].name != NULL; i++) {
+		if (strcmp(md_node_ops_table[i].name, client->node_name) = 0) {
+			supported = true;
+			break;
+		}
+	}
+
+	if (!supported) {
+		pr_err("MD: %s node not supported\n", client->node_name);
+		mutex_unlock(&mdesc_mutex);
+		return;
+	}
+
 	client->next = client_list;
 	client_list = client;
 
-- 
1.7.1

