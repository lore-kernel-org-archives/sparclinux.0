From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 19 Apr 2011 08:08:40 +0000
Subject: Re: [PATCH 2/3] sparc32: cleanup code for irq init
Message-Id: <4DAD4308.1090901@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1303161944-13611-2-git-send-email-sam@ravnborg.org>
In-Reply-To: <1303161944-13611-2-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Sam Ravnborg wrote:

>Move the iddef to a header file to make the logic more
>obvious in the .c file
>
>Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
>---
> arch/sparc/include/asm/pcic.h |   10 +++++++---
> arch/sparc/kernel/irq_32.c    |    9 +++------
> 2 files changed, 10 insertions(+), 9 deletions(-)
>
>diff --git a/arch/sparc/include/asm/pcic.h b/arch/sparc/include/asm/pcic.h
>index f20ef56..b4c63d1 100644
>--- a/arch/sparc/include/asm/pcic.h
>+++ b/arch/sparc/include/asm/pcic.h
>@@ -29,11 +29,15 @@ struct linux_pcic {
> 	int			pcic_imdim;
> };
> 
>-extern int pcic_probe(void);
>-/* Erm... MJ redefined pcibios_present() so that it does not work early. */
>+#ifdef CONFIG_PCI
> extern int pcic_present(void);
>+extern int pcic_probe(void);
> extern void sun4m_pci_init_IRQ(void);
>-
>+#else
>+extern int pcic_present(void) { return 0; }
>  
>
typo, it should be static inline int pcic_preset... will not compile 
otherwise.

>+static inline int pcic_probe(void) { return 0; }
>+static inline void sun4m_pci_init_IRQ(void) {}
>+#endif
> #endif
> 
> /* Size of PCI I/O space which we relocate. */
>diff --git a/arch/sparc/kernel/irq_32.c b/arch/sparc/kernel/irq_32.c
>index 7c93df4..b2dbb4b 100644
>--- a/arch/sparc/kernel/irq_32.c
>+++ b/arch/sparc/kernel/irq_32.c
>@@ -607,14 +607,11 @@ void __init init_IRQ(void)
> 		break;
> 
> 	case sun4m:
>-#ifdef CONFIG_PCI
> 		pcic_probe();
>-		if (pcic_present()) {
>+		if (pcic_present())
> 			sun4m_pci_init_IRQ();
>-			break;
>-		}
>-#endif
>-		sun4m_init_IRQ();
>+		else
>+			sun4m_init_IRQ();
> 		break;
> 
> 	case sun4d:
>  
>
Similarily you can add "static inline void pci_time_init(void) {};" and 
remove the CONFIG_PCI in time_32.c?

Daniel


diff --git a/arch/sparc/kernel/time_32.c b/arch/sparc/kernel/time_32.c
index ffcf7b5..3db2b06 100644
--- a/arch/sparc/kernel/time_32.c
+++ b/arch/sparc/kernel/time_32.c
@@ -228,17 +228,13 @@ static void __init sbus_time_init(void)

 void __init time_init(void)
 {
-#ifdef CONFIG_PCI
-       extern void pci_time_init(void);
        if (pcic_present()) {
                pci_time_init();
                return;
        }
-#endif
        sbus_time_init();
 }

-
 static int set_rtc_mmss(unsigned long secs)
 {
        struct rtc_device *rtc = rtc_class_open("rtc0");

