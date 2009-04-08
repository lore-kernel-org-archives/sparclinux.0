From: David Miller <davem@davemloft.net>
Date: Wed, 08 Apr 2009 22:26:26 +0000
Subject: Re: SunFire V240 hangs
Message-Id: <20090408.152626.220030913.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090408200711.GA1142@frankengul.org>
In-Reply-To: <20090408200711.GA1142@frankengul.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 8 Apr 2009 23:45:51 +0200

> The easiet is to comment out the line:
> 
>     arch_initcall(pcr_arch_init);
> 
> In the file: arch/sparc/kernel/pcr.c

It won't build since this makes pcr_arch_init() unused
and sparc builds with -Werror.

This patch below might work better.

But even if the NMI isn't working, the NMI test should just timeout
and fail if you wait for 10 or 20 seconds.

diff --git a/arch/sparc/kernel/pcr.c b/arch/sparc/kernel/pcr.c
index 1ae8cdd..62b2b9c 100644
--- a/arch/sparc/kernel/pcr.c
+++ b/arch/sparc/kernel/pcr.c
@@ -123,6 +123,9 @@ int __init pcr_arch_init(void)
 
 	if (err)
 		return err;
+#if 1
+	return -ENODEV;
+#endif
 
 	switch (tlb_type) {
 	case hypervisor:
