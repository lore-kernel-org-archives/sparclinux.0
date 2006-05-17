From: "H. Peter Anvin" <hpa@zytor.com>
Date: Wed, 17 May 2006 20:37:12 +0000
Subject: klibc and SPARC
Message-Id: <e4g1ho$dae$1@terminus.zytor.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello all,

As most of you know, I'm trying to move a bunch of Linux
initialization code into early userspace, "klibc".  This is now in
2.6.17-rc4-mm1, and I've gotten a sparc64-related bug report,
specifially related to the following:

[arch/sparc64/kernel/setup.c]


#ifdef CONFIG_IP_PNP
        if (!ic_set_manually) {
                int chosen = prom_finddevice ("/chosen");
                u32 cl, sv, gw;

                cl = prom_getintdefault (chosen, "client-ip", 0);
                sv = prom_getintdefault (chosen, "server-ip", 0);
                gw = prom_getintdefault (chosen, "gateway-ip", 0);
                if (cl && sv) {
                        ic_myaddr = cl;
                        ic_servaddr = sv;
                        if (gw)
                                ic_gateway = gw;
#if defined(CONFIG_IP_PNP_BOOTP) || defined(CONFIG_IP_PNP_RARP)
                        ic_proto_enabled = 0;
#endif
                }
        }
#endif

Is there a way to get that information from userspace, and if not,
should there be a general way to do it or an ad hoc solution?  It sort
of looks like arch/sparc64/prom describes a form of filesystem, but I
don't see any obvious userspace interface.

	-hpa
