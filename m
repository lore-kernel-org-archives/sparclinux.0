From: Bob Breuer <breuerr@mc.net>
Date: Tue, 21 Dec 2004 05:55:35 +0000
Subject: Re: [1/3] fix HyperSPARC DVMA
Message-Id: <41C7BAD7.4000301@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20041221042037.GY771@holomorphy.com>
In-Reply-To: <20041221042037.GY771@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

William Lee Irwin III wrote:
> DVMA is having aliasing problems.

Here's an updated description for the patch:

HyperSPARC was hit by 2 problems: 1) The iotlb entries must be flushed
to ram and 2) to maintain cache coherency on HyperSPARC the page color
of a cacheable DVMA address and its physical address must match.

This patch adds cache flushes of iotlb changes for all non-viking cpus
and optional page coloring of the ranges returned by bit_map_get_string,
with the page coloring only being used on HyperSPARCs for now.

Bob
