From: "David S. Miller" <davem@redhat.com>
Date: Wed, 07 Jan 2004 20:07:53 +0000
Subject: Re: [BKPATCH]: Add option to define default command line to kernel.
Message-Id: <20040107120753.67198523.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040107182529.GK17280@phunnypharm.org>
In-Reply-To: <20040107182529.GK17280@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 7 Jan 2004 12:03:31 -0800
Keith M Wesolowski <wesolows@foobazco.org> wrote:

> I don't really understand the need for this.  Why not just use the
> PROM boot arguments if you're booting from TFTP?

I agree.  You can even tweak the prom environment vars to force
the command line you want.
