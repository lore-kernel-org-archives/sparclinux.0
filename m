From: "David S. Miller" <davem@redhat.com>
Date: Wed, 25 Feb 2004 08:28:53 +0000
Subject: Re: Linux 2.6.3 still doesn't boot on UltraSparc I
Message-Id: <20040225002853.48433de4.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040224144245.GA468@phunnypharm.org>
In-Reply-To: <20040224144245.GA468@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 24 Feb 2004 09:42:45 -0500
Ben Collins <bcollins@debian.org> wrote:

> Why it's looping with prom_init(), I'm not sure. Maybe the prom cif
> handler and stack aren't getting setup properly. Dave, any ideas?

Nothing jumps to my mind, it might even be just looping inside the
OBP itself, ie. in the prom_printf() call.
