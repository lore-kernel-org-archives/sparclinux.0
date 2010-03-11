From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 11 Mar 2010 18:06:22 +0000
Subject: [PATCH 28/37] drivers/scsi: use .of_node instead of .archdata.of_node
Message-Id: <20100311180622.4824.54684.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20100311174830.4824.19820.stgit@angua>
In-Reply-To: <20100311174830.4824.19820.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: monstr@monstr.eu, gregkh@suse.de, benh@kernel.crashing.org, akpm@linux-foundation.org, davem@davemloft.net, sfr@canb.auug.org.au, jgarzik@pobox.com, ben-linux@fluff.org, dwmw2@infrade

.archdata.node is being removed from Microblaze, SPARC and PowerPC.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/scsi/ibmvscsi/ibmvfc.c   |    2 +-
 drivers/scsi/ibmvscsi/ibmvscsi.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index 732f6d3..e230cd4 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -1155,7 +1155,7 @@ static void ibmvfc_gather_partition_info(struct ibmvfc_host *vhost)
 static void ibmvfc_set_login_info(struct ibmvfc_host *vhost)
 {
 	struct ibmvfc_npiv_login *login_info = &vhost->login_info;
-	struct device_node *of_node = vhost->dev->archdata.of_node;
+	struct device_node *of_node = vhost->dev->of_node;
 	const char *location;
 
 	memset(login_info, 0, sizeof(*login_info));
diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index e3a18e0..c4b5af3 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -955,7 +955,7 @@ static void send_mad_capabilities(struct ibmvscsi_host_data *hostdata)
 	struct viosrp_capabilities *req;
 	struct srp_event_struct *evt_struct;
 	unsigned long flags;
-	struct device_node *of_node = hostdata->dev->archdata.of_node;
+	struct device_node *of_node = hostdata->dev->of_node;
 	const char *location;
 
 	evt_struct = get_event_struct(&hostdata->pool);

