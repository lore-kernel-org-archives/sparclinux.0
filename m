From: "David S. Miller" <davem@redhat.com>
Date: Fri, 09 Apr 2004 06:22:33 +0000
Subject: Re: Can't boot linux on sun blade 2000
Message-Id: <20040408232233.00319cfc.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200404071043.30060.snake@penza-gsm.ru>
In-Reply-To: <200404071043.30060.snake@penza-gsm.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 9 Apr 2004 08:10:36 +0400
Alexey Nezhdanov <snake@penza-gsm.ru> wrote:

>  0   pci    33            2  SUNW,Expert3D-Lite (display)  SUNW,375-0116      

Yeah, yank this out of the machine and use the
m64 as your console.

Either that or Ben needs to start building the PROM fb
console driver into the tree if he isn't already.
I bet that's why the other distribution's kernel works.
