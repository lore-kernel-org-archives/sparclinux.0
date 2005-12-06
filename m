From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 06 Dec 2005 02:17:32 +0000
Subject: Re: Sparc: Kernel 2.6.13 to 2.6.15-rc2 bug when running X11
Message-Id: <20051205.181732.34234732.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0512060257160.27930@lai.local.lan>
In-Reply-To: <Pine.LNX.4.64.0512060257160.27930@lai.local.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: trizt@iname.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: "J.O. Aho" <trizt@iname.com>
Date: Tue, 6 Dec 2005 03:04:11 +0100 (CET)

> The dmesg entry comes from 2.6.15-rc2, but is kind of the same, expect not 
> all versions has the ugly and annoying face.

1) Lots of problems have been fixed that trigger that bug message,
   please give 2.6.15-rc5 a spin.

2) You didn't give what the failure mode is for kernels such
   as 2.6.14.2, which should work, and certainly don't print out
   that bug message

3) Finally, this discussion belongs on sparclinux@vger.kernel.org (CC'd),
   not linux-kernel.
