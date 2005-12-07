From: Ben Collins <bcollins@ubuntu.com>
Date: Wed, 07 Dec 2005 14:07:18 +0000
Subject: Re: Sparc: Kernel 2.6.13 to 2.6.15-rc2 bug when running X11
Message-Id: <1133964439.23898.1.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0512060257160.27930@lai.local.lan>
 <20051205.181732.34234732.davem@davemloft.net>
 <Pine.LNX.4.64.0512061658190.14952@lai.local.lan>
 <20051206.152316.82233251.davem@davemloft.net>
 <Pine.LNX.4.64.0512071203460.8861@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0512071203460.8861@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "J.O. Aho" <trizt@iname.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel maillist <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

On Wed, 2005-12-07 at 12:05 +0100, J.O. Aho wrote:
> Xorg jumps to VT7, you see a console cursor, "_", at the top left corner 
> and thats it. It's impossible to change back to VT1 (or any other), the 
> only thing that works is to press [stop]-[a] so that you get back to the
> OBP from where I can reset the machine (resetting by the reset button 
> don't work). It's still possible to ssh to the machine, more and dmesg is 
> possible, but running ps causes the machine to completly lock up, change 
> init mode don't give any affects att all and trying to turn off or kill X 
> results in the same as ps.

Does the dmesg contain any sort of oops?

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

