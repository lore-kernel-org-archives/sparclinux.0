From: "H. Peter Anvin" <hpa@zytor.com>
Date: Thu, 18 May 2006 19:17:20 +0000
Subject: Re: klibc and SPARC
Message-Id: <446CC840.8000006@zytor.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060601060507090501040304"
List-Id: <sparclinux.vger.kernel.org>
References: <e4g1ho$dae$1@terminus.zytor.com>
In-Reply-To: <e4g1ho$dae$1@terminus.zytor.com>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------060601060507090501040304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

David S. Miller wrote:
> From: "H. Peter Anvin" <hpa@zytor.com>
> Date: Wed, 17 May 2006 16:10:51 -0700
> 
>> Well, I'm happy to do it either which way.  I'll go ahead and write
>> up an ad hoc solution for this case, unless it turns out to actually
>> be bigger than one of the generic codes.
> 
> Note you could export these specific values via procfs/sysfs.
> 
> Just an idea...

After thinking about it some more, I decided to drop the information into a file in the 
rootfs.  That way there is no "normal runtime" memory footprint, which would be the main 
reason to avoid the normal drivers.

The kernel side of the patch is attached for review; there is obviously also a kinit side 
which I haven't written yet (I'll try to finish the whole thing this evening.)

	-hpa


--------------060601060507090501040304
Content-Type: text/x-patch;
 name="sparc64.arch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sparc64.arch.diff"

diff --git a/arch/sparc64/kernel/setup.c b/arch/sparc64/kernel/setup.c
index 005167f..a124cb0 100644
--- a/arch/sparc64/kernel/setup.c
+++ b/arch/sparc64/kernel/setup.c
@@ -102,7 +102,7 @@ int obp_system_intr(void)
 	return 0;
 }
 
-/* 
+/*
  * Process kernel command line switches that are specific to the
  * SPARC or that require special low-level processing.
  */
@@ -315,6 +315,53 @@ static void __init sun4v_patch(void)
 	}
 }
 
+/*
+ * Platform-specific configuration commands which don't come from
+ * the actual kernel command line.  Write them into a file in rootfs
+ * so kinit can pick them up.
+ */
+static void __init set_arch_init_commands(void)
+{
+	int fd = sys_open("/arch.cmd", O_WRONLY|O_CREATE|O_APPEND, 0666);
+	int chosen = prom_finddevice ("/chosen");
+	u32 cl, sv, gw;
+	char buffer[256];
+	int len = 0;
+
+	if (fd < 0)
+		return;
+
+	cl = prom_getintdefault (chosen, "client-ip", 0);
+	sv = prom_getintdefault (chosen, "server-ip", 0);
+	gw = prom_getintdefault (chosen, "gateway-ip", 0);
+
+#ifdef CONFIG_BLK_DEV_RAM
+	len = min(sizeof buffer - 1,
+		  snprintf(buffer, sizeof buffer,
+			   "ramdisk_start=%u\n"
+			   "prompt_ramdisk=%d\n"
+			   "load_ramdisk=%d\n",
+			   ram_flags & RAMDISK_IMAGE_START_MASK,
+			   !!(ram_flags & RAMDISK_PROMPT_FLAG),
+			   !!(ram_flags & RAMDISK_LOAD_FLAG)));
+#endif
+	if (cl && sv) {
+		len += min(sizeof buffer - 1 - len,
+			   snprintf(buffer+len, sizeof buffer - len,
+				    "ip=%u.%u.%u.%u:%u.%u.%u.%u:"
+				    "%u.%u.%u.%u\n",
+				    (u8)(cl >> 24), (u8)(cl >> 16),
+				    (u8)(cl >> 8), (u8)cl,
+				    (u8)(sv >> 24), (u8)(sv >> 16),
+				    (u8)(sv >> 8), (u8)sv,
+				    (u8)(gw >> 24), (u8)(gw >> 16),
+				    (u8)(gw >> 8), (u8)gw));
+	}
+
+	sys_write(fd, buffer, len);
+	sys_close(fd);
+}
+
 void __init setup_arch(char **cmdline_p)
 {
 	/* Initialize PROM console and command line. */
@@ -349,33 +396,10 @@ #endif
 	if (!root_flags)
 		root_mountflags &= ~MS_RDONLY;
 	ROOT_DEV = old_decode_dev(root_dev);
-#ifdef CONFIG_BLK_DEV_RAM
-	rd_image_start = ram_flags & RAMDISK_IMAGE_START_MASK;
-	rd_prompt = ((ram_flags & RAMDISK_PROMPT_FLAG) != 0);
-	rd_doload = ((ram_flags & RAMDISK_LOAD_FLAG) != 0);	
-#endif
 
 	task_thread_info(&init_task)->kregs = &fake_swapper_regs;
 
-#ifdef CONFIG_IP_PNP
-	if (!ic_set_manually) {
-		int chosen = prom_finddevice ("/chosen");
-		u32 cl, sv, gw;
-		
-		cl = prom_getintdefault (chosen, "client-ip", 0);
-		sv = prom_getintdefault (chosen, "server-ip", 0);
-		gw = prom_getintdefault (chosen, "gateway-ip", 0);
-		if (cl && sv) {
-			ic_myaddr = cl;
-			ic_servaddr = sv;
-			if (gw)
-				ic_gateway = gw;
-#if defined(CONFIG_IP_PNP_BOOTP) || defined(CONFIG_IP_PNP_RARP)
-			ic_proto_enabled = 0;
-#endif
-		}
-	}
-#endif
+	set_arch_init_commands();
 
 	smp_setup_cpu_possible_map();
 
@@ -439,7 +463,7 @@ static int ncpus_probed;
 
 static int show_cpuinfo(struct seq_file *m, void *__unused)
 {
-	seq_printf(m, 
+	seq_printf(m,
 		   "cpu\t\t: %s\n"
 		   "fpu\t\t: %s\n"
 		   "prom\t\t: %s\n"

--------------060601060507090501040304--
