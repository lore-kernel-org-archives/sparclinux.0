From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 07 Feb 2005 19:55:33 +0000
Subject: Re: Hang in SIOCGIFCONF ioctl handler
Message-Id: <20050207115533.763fbd46.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0502071259370.2050@bobcat>
In-Reply-To: <Pine.LNX.4.61.0502071259370.2050@bobcat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 7 Feb 2005 13:21:16 -0500 (EST)
Jurij Smakov <jurij@wooyd.org> wrote:

> 510                 size_t len =((ifc32.ifc_len / sizeof (struct ifreq32)) + 1) *
> 511                         sizeof (struct ifreq);
> 512                 uifc = compat_alloc_user_space(sizeof(struct ifconf) + len);
> 513                 ifc.ifc_len = len;
> 514                 ifr = ifc.ifc_req = (void __user *)(uifc + 1);
> 515                 ifr32 = compat_ptr(ifc32.ifcbuf);
> 516                 for (i = 0; i < ifc32.ifc_len; i += sizeof (struct ifreq32)) {
> 517                         if (copy_in_user(ifr, ifr32, sizeof(struct ifreq32)))
> 518                                 return -EFAULT;
> 519                         ifr++;
> 520                         ifr32++; 
> 521                 }
> 
> By inserting some debugging statements, I was able to figure out that 
> machine hangs because at some point the call to copy_in_user function does 
> not return.

How big are the values "ifc32.ifc_len" and the length passed into the
compat_alloc_user_space() call for the failure case?
