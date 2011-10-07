From: Meelis Roos <mroos@linux.ee>
Date: Fri, 07 Oct 2011 07:53:57 +0000
Subject: [PATCH] qlogicpti: increase timeout
Message-Id: <alpine.SOC.1.00.1110071050080.648@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org

qlogicpti times out for some tape library operations (like mtx 
inventory). It seems SCSI command timeout is hardcoded into the driver. 
So let's increase it to some arbitrary higher value that Works For 
Me(tm).

Signed-off-by: Meelis Roos <mroos@linux.ee>

diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index 9689d41c..4290141 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -880,7 +880,7 @@ static inline void cmd_frob(struct Command_Entry *cmd, struct scsi_cmnd *Cmnd,
 		cmd->control_flags |= CFLAG_WRITE;
 	else
 		cmd->control_flags |= CFLAG_READ;
-	cmd->time_out = 30;
+	cmd->time_out = 120;
 	memcpy(cmd->cdb, Cmnd->cmnd, Cmnd->cmd_len);
 }
 

-- 
Meelis Roos (mroos@linux.ee)
