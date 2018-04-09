From: Rob Herring <robh@kernel.org>
Date: Mon, 09 Apr 2018 20:52:38 +0000
Subject: Re: [PATCH] drivers/of: Introduce ARCH_HAS_OWN_OF_NUMA
Message-Id: <CAL_Jsq+ho2QhmNmPZMDJcfSxposJd=jYDvjhXH8cMAtVFP7n4A@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180409074604.17671-1-oohall@gmail.com>
In-Reply-To: <20180409074604.17671-1-oohall@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Oliver O'Halloran <oohall@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-nvdimm@lists.01.org, devicetree@vger.kernel.org, sparclinux@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

On Mon, Apr 9, 2018 at 2:46 AM, Oliver O'Halloran <oohall@gmail.com> wrote:
> Some OF platforms (pseries and some SPARC systems) has their own
> implementations of NUMA affinity detection rather than using the generic
> OF_NUMA driver, which mainly exists for arm64. For other platforms one
> of two fallbacks provided by the base OF driver are used depending on
> CONFIG_NUMA.
>
> In the CONFIG_NUMA=n case the fallback is an inline function in of.h.
> In the =y case the fallback is a real function which is defined as a
> weak symbol so that it may be overwritten by the architecture if desired.
>
> The problem with this arrangement is that the real implementations all
> export of_node_to_nid(). Unfortunately it's not possible to export the
> fallback since it would clash with the non-weak version. As a result
> we get build failures when:
>
> a) CONFIG_NUMA=y && CONFIG_OF=y, and
> b) The platform doesn't implement of_node_to_nid(), and
> c) A module uses of_node_to_nid()
>
> Given b) will be true for most platforms this is fairly easy to hit
> and has been observed on ia64 and x86.

How specifically do we hit this? The only module I see using
of_node_to_nid in mainline is Cell EDAC driver.

> This patch remedies the problem by introducing the ARCH_HAS_OWN_OF_NUMA
> Kconfig option which is selected if an architecture provides an
> implementation of of_node_to_nid(). If a platform does not use it's own,
> or the generic OF_NUMA, then always use the inline fallback in of.h so
> we don't need to futz around with exports.

I'm more inclined to figure out how to remove the export and provide a
non DT specific function if drivers need to know this.

Rob
