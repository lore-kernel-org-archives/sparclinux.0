From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 04 Mar 2005 07:06:58 +0000
Subject: Re: [PATCH] sparc: fix compile failure ("struct resource" related)
Message-Id: <20050303230658.21b54e56.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050301134440.05ae1152.akpm@osdl.org>
In-Reply-To: <20050301134440.05ae1152.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 03 Mar 2005 23:21:15 +0000
Chris Newport <crn@netunix.com> wrote:

> In general, you should not need to have the Sun firmware in your
> drivers, just upload them to the card and array from Solaris and they
> will stay there in nvram.

Not true if you boot from the SOC/SOCAL disks, OBP will load it's
own firmware which is very slow and has tons of debugging enabled
in it.
