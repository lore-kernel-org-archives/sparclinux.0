From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 15 Dec 2004 03:11:58 +0000
Subject: Re: Mismatched UltraSPARC III CPUs
Message-Id: <20041214191158.76044ce3.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20041214190448.6584bf2d@enterprise.weeve.org>
In-Reply-To: <20041214190448.6584bf2d@enterprise.weeve.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 14 Dec 2004 19:04:48 -0700
Jason Wever <weeve@gentoo.org> wrote:

> As OBP on the Blade 1000/2000 supports mismatched USIII CPUs, I was
> wondering if the kernel is capable of doing that as well.

Yes, even the cpu frequency changing support in the 2.6.x kernel
handles this as well.
