From: hyl <heyongli@gmail.com>
Date: Wed, 23 Sep 2009 04:37:48 +0000
Subject: Linux guest domain with two vnets bound to the same vswitch
Message-Id: <505766fa0909222137q217be3d0x8fc12ab467833666@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>

console output:

e1000e: Intel(R) PRO/1000 Network Driver - 0.3.3.3-k6
e1000e: Intel(R) PRO/1000 Network Driver - 0.3.3.3-k6
e1000e: Copyright (c) 1999-2008 Intel Corporation.
e1000e: Copyright (c) 1999-2008 Intel Corporation.
sunvnet.c:v1.0 (June 25, 2007)
sunvnet.c:v1.0 (June 25, 2007)
eth0: Sun LDOM vnet 00:14:4f:f9:68:e0:t
e0
eth0: PORT ( remote-mac 00:14:4f:fa:03:81 switch-port )
eth0: PORT ( remote-mac 00:14:4f:fa:03:81 switch-port )
eth0: PORT ( remote-mac 00:14:4f:f9:84:06 )
eth0: PORT ( remote-mac 00:14:4f:f9:84:06 )
eth0: PORT ( remote-mac 00:14:4f:f9:9a:40 )
eth0: PORT ( remote-mac 00:14:4f:f9:9a:40 )
eth0: PORT ( remote-mac 00:14:4f:f8:c5:7b )
eth0: PORT ( remote-mac 00:14:4f:f8:c5:7b )
eth1: Sun LDOM vnet 00:14:4f:f8:c5:7b:t
7b
eth1: PORT ( remote-mac 00:14:4f:fa:03:81 switch-port )
eth1: PORT ( remote-mac 00:14:4f:fa:03:81 switch-port )
eth1: PORT ( remote-mac 00:14:4f:f9:84:06 )
eth1: PORT ( remote-mac 00:14:4f:f9:84:06 )
eth1: PORT ( remote-mac 00:14:4f:f9:9a:40 )
eth1: PORT ( remote-mac 00:14:4f:f9:9a:40 )
eth1: PORT ( remote-mac 00:14:4f:f9:68:e0 )
eth1: PORT ( remote-mac 00:14:4f:f9:68:e0 )

two vnets bound to the same vswitch, then hang,
ldm add-vnet vnet0 primary-vsw1 dom1
ldm add-vnet vnet1 primary-vsw1 ldom1

If 'eth1' and 'eth2' are bound to different vswitches, everything is fine.


Yongli He
