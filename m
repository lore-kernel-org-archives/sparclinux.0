From: Tushar Dave <tushar.n.dave@oracle.com>
Date: Tue, 15 Aug 2017 22:07:35 +0000
Subject: Re: Niagara2 & Could not register hvapi ATU err=-22
Message-Id: <5689d5bc-4657-4d60-34fa-02bb6b3eb58a@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1708151738450.29628@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1708151738450.29628@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On 08/15/2017 07:42 AM, Meelis Roos wrote:
> I noticed that on Niagara2, dmesg has a red error about ATU
> registration:
> 
> [    4.579231] pci_sun4v: Could not register hvapi ATU err=-22
> 
> This is preceded by info line
> [    4.578073] pci_sun4v: Registered hvapi major[1] minor[0]
> 
> As I understand, there is no ATU on Niagara1 & Niagara2 sun4v platforms,
> so there is no point in trying to log an error to dmesg in that case?
You are right.
IMO, we should not log ATU hvapi registration failure message at all. 
Unlike PCI hvapi, ATU hvapi registration failure is not *hard error*.
Even if ATU hvapi registration fails (on system with ATU or without ATU) 
system continues with legacy IOMMU.
So I think log message only when ATU is registered successfully.

diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index f10e2f7..9ebebf1 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -1266,8 +1266,6 @@ static int pci_sun4v_probe(struct platform_device *op)
                          * ATU group, but ATU hcalls won't be available.
                          */
                         hv_atu = false;
-                       pr_err(PFX "Could not register hvapi ATU err=%d\n",
-                              err);
                 } else {
                         pr_info(PFX "Registered hvapi ATU major[%lu] 
minor[%lu]\n",
                                 vatu_major, vatu_minor);


-Tushar
