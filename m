From: "David S. Miller" <davem@redhat.com>
Date: Mon, 12 Jan 2004 17:57:54 +0000
Subject: Re: [2.6.1] still no working keyboard/mouse on ultra-enterprise 2
Message-Id: <20040112095754.7b07bddb.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040112140940.C4116@pc9391.uni-regensburg.de>
In-Reply-To: <20040112140940.C4116@pc9391.uni-regensburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 12 Jan 2004 15:46:06 +0000
Ciaran McCreesh <ciaranm@gentoo.org> wrote:

> Are you using the 2.4-style KEYMAPs? I don't know how Debian handles
> this, but in Gentoo it's necessary to comment out the KEYMAP="sunkeymap"
> line in /etc/rc.conf (or replace it with an x86-style setting if you
> prefer).

I bet that's exactly what this person's problem is.

You cannot load Sun style keymaps any longer, it will result in garbage
or nothing when you type keys.  You need to use x86 style keymaps on
all platforms now in 2.6.1
