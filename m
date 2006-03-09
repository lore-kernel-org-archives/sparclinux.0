From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 09 Mar 2006 05:49:34 +0000
Subject: ESP busted (was Re: Best bet for SPARC SMP and Sunfire V240)
Message-Id: <20060308.214934.08182363.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josh Grebe <josh@brokedown.net>
Date: Wed, 08 Mar 2006 21:54:31 -0600

> You Rock.

Now off to your other problem.

Let's try to expose more of what's going on to the compiler
in hopes it will inline things correctly.

Try this patch and do a "make drivers/scsi/esp.s" and send
me that esp.s file.

Thanks.

diff --git a/drivers/scsi/esp.c b/drivers/scsi/esp.c
index 87a8c3d..55dbc8c 100644
--- a/drivers/scsi/esp.c
+++ b/drivers/scsi/esp.c
@@ -3203,19 +3203,6 @@ static int esp_enter_badphase(struct esp
 	return do_reset_bus;
 }
 
-typedef int (*espfunc_t)(struct esp *);
-
-static espfunc_t phase_vector[] = {
-	esp_do_data,		/* ESP_DOP */
-	esp_do_data,		/* ESP_DIP */
-	esp_enter_cmd,		/* ESP_CMDP */
-	esp_enter_status,	/* ESP_STATP */
-	esp_enter_badphase,	/* ESP_STAT_PMSG */
-	esp_enter_badphase,	/* ESP_STAT_PMSG | ESP_STAT_PIO */
-	esp_enter_msgout,	/* ESP_MOP */
-	esp_enter_msgin,	/* ESP_MIP */
-};
-
 /* The target has control of the bus and we have to see where it has
  * taken us.
  */
@@ -3223,7 +3210,25 @@ static int esp_do_phase_determine(struct
 {
 	if ((esp->ireg & ESP_INTR_DC) != 0)
 		return esp_disconnect_amidst_phases(esp);
-	return phase_vector[esp->sreg & ESP_STAT_PMASK](esp);
+
+	switch (esp->sreg & ESP_STAT_PMASK) {
+	case ESP_DOP:
+		return esp_do_data(esp);
+	case ESP_DIP:
+		return esp_do_data(esp);
+	case ESP_CMDP:
+		return esp_enter_cmd(esp);
+	case ESP_STATP:
+		return esp_enter_status(esp);
+	case ESP_STAT_PMSG:
+	case ESP_STAT_PMSG | ESP_STAT_PIO:
+	default:
+		return esp_enter_badphase(esp);
+	case ESP_MOP:
+		return esp_enter_msgout(esp);
+	case ESP_MIP:
+		return esp_enter_msgin(esp);
+	};
 }
 
 /* First interrupt after exec'ing a cmd comes here. */
@@ -4106,25 +4111,6 @@ static int esp_bus_unexpected(struct esp
 	return do_reset_bus;
 }
 
-static espfunc_t bus_vector[] = {
-	esp_do_data_finale,
-	esp_do_data_finale,
-	esp_bus_unexpected,
-	esp_do_msgin,
-	esp_do_msgincont,
-	esp_do_msgindone,
-	esp_do_msgout,
-	esp_do_msgoutdone,
-	esp_do_cmdbegin,
-	esp_do_cmddone,
-	esp_do_status,
-	esp_do_freebus,
-	esp_do_phase_determine,
-	esp_bus_unexpected,
-	esp_bus_unexpected,
-	esp_bus_unexpected,
-};
-
 /* This is the second tier in our dual-level SCSI state machine. */
 static int esp_work_bus(struct esp *esp)
 {
@@ -4137,22 +4123,43 @@ static int esp_work_bus(struct esp *esp)
 		return esp_do_reconnect(esp);
 	}
 	phase = SCptr->SCp.phase;
-	if ((phase & 0xf0) = in_phases_mask)
-		return bus_vector[(phase & 0x0f)](esp);
-	else if ((phase & 0xf0) = in_slct_mask)
+	if ((phase & 0xf0) = in_phases_mask) {
+		switch (phase) {
+		case in_datain:
+			return esp_do_data_finale(esp);
+		case in_dataout:
+			return esp_do_data_finale(esp);
+		case in_data_done:
+			return esp_bus_unexpected(esp);
+		case in_msgin:
+			return esp_do_msgin(esp);
+		case in_msgincont:
+			return esp_do_msgincont(esp);
+		case in_msgindone:
+			return esp_do_msgindone(esp);
+		case in_msgout:
+			return esp_do_msgout(esp);
+		case in_msgoutdone:
+			return esp_do_msgoutdone(esp);
+		case in_cmdbegin:
+			return esp_do_cmdbegin(esp);
+		case in_cmdend:
+			return esp_do_cmddone(esp);
+		case in_status:
+			return esp_do_status(esp);
+		case in_freeing:
+			return esp_do_freebus(esp);
+		case in_the_dark:
+			return esp_do_phase_determine(esp);
+		default:
+			return esp_bus_unexpected(esp);
+		};
+	} else if ((phase & 0xf0) = in_slct_mask)
 		return esp_select_complete(esp);
 	else
 		return esp_bus_unexpected(esp);
 }
 
-static espfunc_t isvc_vector[] = {
-	NULL,
-	esp_do_phase_determine,
-	esp_do_resetbus,
-	esp_finish_reset,
-	esp_work_bus
-};
-
 /* Main interrupt handler for an esp adapter. */
 static void esp_handle(struct esp *esp)
 {
@@ -4323,15 +4330,27 @@ static void esp_handle(struct esp *esp)
 	/* This is tier-one in our dual level SCSI state machine. */
 state_machine:
 	while (what_next != do_intr_end) {
-		if (what_next >= do_phase_determine &&
-		    what_next < do_intr_end) {
-			what_next = isvc_vector[what_next](esp);
-		} else {
+		switch (what_next) {
+		case do_phase_determine:
+			what_next = esp_do_phase_determine(esp);
+			break;
+		case do_reset_bus:
+			what_next = esp_do_resetbus(esp);
+			break;
+		case do_reset_complete:
+			what_next = esp_finish_reset(esp);
+			break;
+		case do_work_bus:
+			what_next = esp_work_bus(esp);
+			break;
+
+		default:
 			/* state is completely lost ;-( */
-			ESPLOG(("esp%d: interrupt engine loses state, resetting bus\n",
-				esp->esp_id));
+			ESPLOG(("esp%d: interrupt engine loses state, "
+				"resetting bus\n", esp->esp_id));
 			what_next = do_reset_bus;
-		}
+			break;
+		};
 	}
 }
 
