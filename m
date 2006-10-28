From: Roland Stigge <stigge@antcom.de>
Date: Sat, 28 Oct 2006 21:23:41 +0000
Subject: Re: Another 2.6.18 regression? (SunBlade1000)
Message-Id: <4543CA5D.8050700@antcom.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20061024031642.GA4403@droopy.oc.cox.net>
In-Reply-To: <20061024031642.GA4403@droopy.oc.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
>> After removing the floppy driver, the result looks a bit different: The
>> bootup proceeds a bit further, but the error message is similar.
>>
>> See http://people.debian.org/~stigge/sun4u-nofd.jpg
> 
> What does 0x4268e8 match up to in your System.map?

Looks like tomatillo_wsync_handler:

0000000000426818 T of_get_parent
0000000000426830 T of_get_next_child
0000000000426844 T of_find_node_by_phandle
0000000000426874 t sabre_wsync_handler
00000000004268c8 t tomatillo_wsync_handler
0000000000426948 T of_find_property
000000000042698c T of_getintprop_default
00000000004269c4 T of_get_property
00000000004269ec t pci_sun4v_irq_trans_init
0000000000426a3c t schizo_irq_trans_init
0000000000426ad8 t sabre_irq_trans_init
0000000000426b48 t psycho_irq_trans_init
