From: "David S. Miller" <davem@redhat.com>
Date: Wed, 24 Mar 2004 08:08:40 +0000
Subject: Re: Slab corruption in 2.6.4-rc1 on sparc64 (sunblade 100)
Message-Id: <20040324000840.7864e9aa.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1078237230.4360.19.camel@zorak>
In-Reply-To: <1078237230.4360.19.camel@zorak>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 23 Mar 2004 17:18:53 -0600
"Tom 'spot' Callaway" <tcallawa@redhat.com> wrote:

> Dmesg attached from U10.

It doesn't say what slab pool is getting corrupted, I'm surprised
it doesn't as that would make this easier to diagnose.
