From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 01 Dec 2016 01:25:30 +0000
Subject: sunvnet: Question on tx control in original code
Message-Id: <161e538d-f353-2075-280b-50767e6ec8d8@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I've recently been studying up on the sparc LDom environment and 
sunvnet, the virtual network device.  In looking through the code I ran 
across an odd bit of tx control that I don't quite understand.

Near the bottom of  sunvnet_common.c:sunvnet_start_xmit_common(), about 
line 1423, just after the ldc_start_done: label is a curious 'if' block

         if (unlikely(vnet_tx_dring_avail(dr) < 1)) {
                 netif_tx_stop_queue(txq);
                 if (vnet_tx_dring_avail(dr) > VNET_TX_WAKEUP_THRESH(dr))
                         netif_tx_wake_queue(txq);
         }

In order to get into the if-block there needs to be a 0 or negative 
return from vnet_tx_dring_avail(), yet then we're checking it again, 
with no discernible delay, for a positive value.  I don't see how we 
could get to the netif_tx_wake_queue() call - shouldn't there be some 
delay, or perhaps something that might bump the underlying channel 
before checking for more available space?

Perhaps I've missed something?

Thanks,
sln

-- 
=========================
Shannon Nelson           shannon.nelson@oracle.com
Parents can't afford to be squeamish
