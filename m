From: "David S. Miller" <davem@redhat.com>
Date: Wed, 14 Jan 2004 07:42:34 +0000
Subject: Re: [PATCH] removing interruptible_sleep_on in
Message-Id: <20040113234234.05db4612.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1074055200.4990.37.camel@zorak>
In-Reply-To: <1074055200.4990.37.camel@zorak>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 13 Jan 2004 22:40:03 -0600
"Tom 'spot' Callaway" <tcallawa@redhat.com> wrote:

> Fedora Core 2's 2.6.1 kernel package is patching interruptible_sleep_on
> (and sleep_on) as deprecated. This causes 
> sparc64 to stop building, since it uses interruptible_sleep_on in
> arch/sparc64/kernel/power.c. I made a best effort to fix this in the
> attached patch, feedback is appreciated.

I will review this and fix it up if needed tomorrow.

Thanks Tom.
