From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Fri, 25 Feb 2005 22:35:39 +0000
Subject: DBRI fixes and improvements [2.4]
Message-Id: <421FA83B.2050901@wp.pl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090107080306010309090308"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------090107080306010309090308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch greatly improves quality of audio output on my Sparcstation 
20. It also contains some other fixes and improvements.

A full list of changes:
- [audio.c] Added missing semicolon when debug information is enabled 
(compilation bug).

- [audio.c] Number of input and output 8KB buffers is now a module 
parameter as previous authors requested. More buffers should help on 
slower machines.

- [audio.c] Fixes some debug strings, so compilation warnings are gone 
(when debug is enabled).

- [dbri.c] Added missing dbri_get_formats() function, so sox/play now 
plays sound files without forcing it to Sun audio output interface (OSS 
works).

- [dbri.c] Enabled burst transfers for DBRI.

- [dbri.c] Added a fix to not leave few bytes in a next memory chunk 
when building chain of output data buffers for DBRI. It is really a 
critical thing if the next change is applied.

- [dbri.c] [the most important one] Writing an output data (playback) 
returns immediately which allows audio player to prepare next data when 
an audio codec is playing the previous. It removes clicking noise on 
output signal.

I tested  it on dual SuperSPARC 60MHz CPU (OGG file playback = 50% usage 
of 1 CPU).
I am interested in feedback about audio quality change on machines of 
different speed.

Regards,
Krzysztof Helt

--------------090107080306010309090308
Content-Type: text/plain;
 name="audio-dbri.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="audio-dbri.diff"

diff -ru linux-2.4.27/drivers/sbus/audio/audio.c /tmp/drivers/sbus/audio/audio.c
--- linux-2.4.27/drivers/sbus/audio/audio.c	2001-10-11 08:42:46.000000000 +0200
+++ /tmp/drivers/sbus/audio/audio.c	2005-02-25 23:05:11.000000000 +0100
@@ -65,6 +65,14 @@
 #define tprintk(x)
 #endif
 
+static int  audio_input_buffers = 8;
+MODULE_PARM(audio_input_buffers, "i");
+MODULE_PARM_DESC(audio_input_buffers,"Number of input 8KB buffers.");
+
+static int  audio_output_buffers = 8;
+MODULE_PARM(audio_output_buffers, "i");
+MODULE_PARM_DESC(audio_output_buffers,"Number of output 8KB buffer.");
+
 static short lis_get_elist_ent( strevent_t *list, pid_t pid );
 static int lis_add_to_elist( strevent_t **list, pid_t pid, short events );
 static int lis_del_from_elist( strevent_t **list, pid_t pid, short events );
@@ -438,7 +446,7 @@
                         m = drv->ops->get_input_balance(drv);
                 i = OSS_TO_GAIN(k);
                 j = OSS_TO_BAL(k);
-                oprintk((" for stereo to do %d (bal %d):", i, j));
+                oprintk((" for stereo to do %ld (bal %ld):", i, j));
                 if (drv->ops->set_input_volume)
                         drv->ops->set_input_volume(drv, i);
                 if (drv->ops->set_input_balance)
@@ -488,7 +496,7 @@
                 oprintk((" started as (0x%x)\n", BAL_TO_OSS(l,m)));
                 i = OSS_TO_GAIN(k);
                 j = OSS_TO_BAL(k);
-                oprintk((" for stereo to %d (bal %d)\n", i, j));
+                oprintk((" for stereo to %ld (bal %ld)\n", i, j));
                 if (drv->ops->set_output_volume)
                         drv->ops->set_output_volume(drv, i);
                 if (drv->ops->set_output_balance)
@@ -565,7 +573,7 @@
           if (k & SOUND_MASK_CD) j = AUDIO_CD;
           if (k & SOUND_MASK_LINE) j = AUDIO_LINE_IN;
           if (k & SOUND_MASK_MIC) j = AUDIO_MICROPHONE;
-          oprintk(("setting inport to %d\n", j));
+          oprintk(("setting inport to %ld\n", j));
           i = drv->ops->set_input_port(drv, j);
     
           return put_user(i, (int *)arg);
@@ -798,7 +806,7 @@
                                 retval = -EINVAL;
                                 break;
                         }
-                        get_user(i, (int *)arg)
+                        get_user(i, (int *)arg);
                         tprintk(("setting speed to %d\n", i));
                         drv->ops->set_input_rate(drv, i);
                         drv->ops->set_output_rate(drv, i);
@@ -1955,8 +1963,6 @@
          * Input buffers, on the other hand, always fill completely,
          * so we don't need input counts - each contains input_buffer_size
          * bytes of audio data.
-         *
-         * TODO: Make number of input/output buffers tunable parameters
          */
 
         init_waitqueue_head(&drv->open_wait);
@@ -1964,7 +1970,7 @@
         init_waitqueue_head(&drv->output_drain_wait);
         init_waitqueue_head(&drv->input_read_wait);
 
-        drv->num_output_buffers = 8;
+        drv->num_output_buffers = audio_output_buffers;
 	drv->output_buffer_size = (4096 * 2);
 	drv->playing_count = 0;
 	drv->output_offset = 0;
@@ -1997,7 +2003,7 @@
         }
 
         /* Setup the circular queue of input buffers. */
-        drv->num_input_buffers = 8;
+        drv->num_input_buffers = audio_input_buffers;
 	drv->input_buffer_size = (4096 * 2);
 	drv->recording_count = 0;
         drv->input_front = 0;
diff -ru linux-2.4.27/drivers/sbus/audio/dbri.c /tmp/drivers/sbus/audio/dbri.c
--- linux-2.4.27/drivers/sbus/audio/dbri.c	2002-11-29 00:53:14.000000000 +0100
+++ /tmp/drivers/sbus/audio/dbri.c	2005-02-25 23:09:25.000000000 +0100
@@ -51,6 +51,7 @@
 #include <linux/slab.h>
 #include <linux/version.h>
 #include <linux/delay.h>
+#include <linux/soundcard.h>
 #include <asm/openprom.h>
 #include <asm/oplib.h>
 #include <asm/system.h>
@@ -161,7 +162,7 @@
 
 static void dbri_process_interrupt_buffer(struct dbri *);
 
-static void dbri_cmdsend(struct dbri *dbri, volatile s32 *cmd)
+static void dbri_cmdsend(struct dbri *dbri, volatile s32 *cmd, int pause)
 {
 	int MAXLOOPS = 1000000;
 	int maxloops = MAXLOOPS;
@@ -181,25 +182,30 @@
         } else if ((cmd - &dbri->dma->cmd[0]) >= DBRI_NO_CMDS-1) {
                 printk("DBRI: Command buffer overflow! (bug in driver)\n");
         } else {
-                *(cmd++) = DBRI_CMD(D_PAUSE, 0, 0);
+                if (pause) 
+			*(cmd++) = DBRI_CMD(D_PAUSE, 0, 0);
 		*(cmd++) = DBRI_CMD(D_WAIT, 1, 0);
 		dbri->wait_seen = 0;
                 sbus_writel(dbri->dma_dvma, dbri->regs + REG8);
-		while ((--maxloops) > 0 &&
-                       (sbus_readl(dbri->regs + REG0) & D_P))
-                        barrier();
-		if (maxloops == 0) {
-			printk("DBRI: Chip never completed command buffer\n");
-		} else {
-			while ((--maxloops) > 0 && (! dbri->wait_seen))
-				dbri_process_interrupt_buffer(dbri);
+		if (pause) {
+			while ((--maxloops) > 0 &&
+			       (sbus_readl(dbri->regs + REG0) & D_P))
+				barrier();
 			if (maxloops == 0) {
-				printk("DBRI: Chip never acked WAIT\n");
+				printk("DBRI: Chip never completed command buffer\n");
 			} else {
-				dprintk(D_INT, ("DBRI: Chip completed command "
-                                                "buffer (%d)\n",
-						MAXLOOPS - maxloops));
+				while ((--maxloops) > 0 && (! dbri->wait_seen))
+					dbri_process_interrupt_buffer(dbri);
+				if (maxloops == 0) {
+					printk("DBRI: Chip never acked WAIT\n");
+				} else {
+					dprintk(D_INT, ("DBRI: Chip completed command "
+							"buffer (%d)\n",
+							MAXLOOPS - maxloops));
+				}
 			}
+		} else {
+			dprintk(D_INT, ("DBRI: NO PAUSE\n"));
 		}
         }
 
@@ -257,7 +263,10 @@
         /* We should query the openprom to see what burst sizes this
          * SBus supports.  For now, just disable all SBus bursts */
         tmp = sbus_readl(dbri->regs + REG0);
-        tmp &= ~(D_G | D_S | D_E);
+	/* A brute approach - DBRI falls back to working burst size by itself
+	 * On SS20 D_S does not work, so do not try so high. */
+        tmp |= D_G | D_E;
+        tmp &= ~D_S;
         sbus_writel(tmp, dbri->regs + REG0);
 
 	/*
@@ -268,7 +277,7 @@
 	*(cmd++) = DBRI_CMD(D_IIQ, 0, 0);
 	*(cmd++) = dma_addr;
 
-        dbri_cmdsend(dbri, cmd);
+        dbri_cmdsend(dbri, cmd, 1);
 }
 
 
@@ -455,7 +464,7 @@
 				    dbri->pipes[pipe].sdp
 				    | D_SDP_P | D_SDP_C | D_SDP_2SAME);
                 *(cmd++) = dbri->dma_dvma + dbri_dma_off(desc, td);
-		dbri_cmdsend(dbri, cmd);
+		dbri_cmdsend(dbri, cmd, 1);
 	}
 
 	if (code == D_INTR_FXDT) {
@@ -579,7 +588,7 @@
         cmd = dbri_cmdlock(dbri);
         *(cmd++) = DBRI_CMD(D_SDP, 0, sdp | D_SDP_C | D_SDP_P);
         *(cmd++) = 0;
-        dbri_cmdsend(dbri, cmd);
+        dbri_cmdsend(dbri, cmd, 1);
 
 	desc = dbri->pipes[pipe].desc;
 	while (desc != -1) {
@@ -722,7 +731,7 @@
 		*(cmd++) = D_TS_LEN(length) | D_TS_CYCLE(cycle) | D_TS_NEXT(nextpipe);
 	}
 
-        dbri_cmdsend(dbri, cmd);
+        dbri_cmdsend(dbri, cmd, 1);
 }
 
 /* I don't use this function, so it's basically untested. */
@@ -752,7 +761,7 @@
 		*(cmd++) = D_TS_NEXT(nextpipe);
         }
 
-        dbri_cmdsend(dbri, cmd);
+        dbri_cmdsend(dbri, cmd, 1);
 }
 
 /* xmit_fixed() / recv_fixed()
@@ -803,7 +812,7 @@
         *(cmd++) = DBRI_CMD(D_SSP, 0, pipe);
         *(cmd++) = data;
 
-        dbri_cmdsend(dbri, cmd);
+        dbri_cmdsend(dbri, cmd, 1);
 }
 
 static void recv_fixed(struct dbri *dbri, int pipe, volatile __u32 *ptr)
@@ -884,7 +893,9 @@
                 }
 
                 if (len > ((1 << 13) - 1)) {
-                        mylen = (1 << 13) - 1;
+		/* One should not leave a buffer shorter than    */
+		/* a single sample. Otherwise bad things happen. */
+                        mylen = (1 << 13) - 4;
                 } else {
                         mylen = len;
                 }
@@ -954,7 +965,7 @@
 
 		cmd = dbri_cmdlock(dbri);
 		*(cmd++) = DBRI_CMD(D_CDP, 0, pipe);
-		dbri_cmdsend(dbri,cmd);
+		dbri_cmdsend(dbri,cmd, 0);
 	} else {
 		/* Pipe isn't active - issue an SDP command to start
 		 * our chain of TDs running.
@@ -965,7 +976,7 @@
 				    dbri->pipes[pipe].sdp
 				    | D_SDP_P | D_SDP_EVERY | D_SDP_C);
                 *(cmd++) = dbri->dma_dvma + dbri_dma_off(desc, first_td);
-		dbri_cmdsend(dbri, cmd);
+		dbri_cmdsend(dbri, cmd, 0);
 	}
 
 	restore_flags(flags);
@@ -1083,7 +1094,7 @@
 	*(cmd++) = DBRI_CMD(D_SDP, 0, dbri->pipes[pipe].sdp | D_SDP_P | D_SDP_C);
         *(cmd++) = dbri->dma_dvma + dbri_dma_off(desc, first_rd);
 
-        dbri_cmdsend(dbri, cmd);
+        dbri_cmdsend(dbri, cmd, 1);
 }
 
 
@@ -1191,7 +1202,7 @@
 	*(cmd++) = DBRI_CMD(D_PAUSE, 0, 0);
 	*(cmd++) = DBRI_CMD(D_CDM, 0, D_CDM_XCE|D_CDM_XEN|D_CDM_REN);
 
-	dbri_cmdsend(dbri, cmd);
+	dbri_cmdsend(dbri, cmd, 1);
 }
 
 /*
@@ -1538,7 +1549,6 @@
 	xmit_on_pipe(dbri, 4, buffer, count,
 		     &dbri_audio_output_callback, drv);
 
-#if 0
 	/* Notify midlevel that we're a DMA-capable driver that
 	 * can accept another buffer immediately.  We should probably
 	 * check that we've got enough resources (i.e, descriptors)
@@ -1551,9 +1561,14 @@
 	 * DBRI with a chain of buffers, but the midlevel code is
 	 * so tricky that I really don't want to deal with it.
 	 */
+	/*
+	 * This must be enabled otherwise the output is noisy
+	 * as return to user space is done when all buffers
+	 * are already played, so user space player has no time
+  	 * to prepare next ones without a period of silence. - Krzysztof Helt
+	 */
 
 	sparcaudio_output_done(drv, 2);
-#endif
 }
 
 static void dbri_stop_output(struct sparcaudio_driver *drv)
@@ -1842,6 +1857,13 @@
 	return dbri_get_output_rate(drv);
 }
 
+static int dbri_get_formats(struct sparcaudio_driver *drv)
+{
+/* 8-bit format is not working */
+        return (AFMT_MU_LAW | AFMT_A_LAW | AFMT_IMA_ADPCM | 
+                AFMT_S16_LE | AFMT_S16_BE);
+}
+
 /******************* sparcaudio midlevel - ports ***********************/
 
 static int dbri_set_output_port(struct sparcaudio_driver *drv, int port)
@@ -1983,6 +2005,19 @@
 	dbri_get_input_ports,
 	dbri_set_output_muted,
 	dbri_get_output_muted,
+	NULL, /* dbri_set_output_pause, */
+	NULL, /* dbri_get_output_pause, */
+	NULL, /* dbri_set_input_pause, */
+	NULL, /* dbri_get_input_pause, */
+	NULL, /* dbri_set_output_samples, */
+	NULL, /* dbri_get_output_samples, */
+	NULL, /* dbri_set_input_samples, */
+	NULL, /* dbri_get_input_samples, */
+	NULL, /* dbri_set_output_error, */
+	NULL, /* dbri_get_output_error, */
+	NULL, /* dbri_set_input_error, */
+	NULL, /* dbri_get_input_error, */
+        dbri_get_formats
 };
 
 
@@ -2093,7 +2128,7 @@
 #endif
 	       *(cmd++) = DBRI_CMD(D_TE, 0, val);
 
-	       dbri_cmdsend(dbri, cmd);
+	       dbri_cmdsend(dbri, cmd, 1);
 
 	       /* Activate the interface */
                tmp = sbus_readl(dbri->regs + REG0);

--------------090107080306010309090308--

