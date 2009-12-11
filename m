From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 11 Dec 2009 07:09:24 +0000
Subject: Re: [PATCH] of: merge of_find_node_by_phandle
Message-Id: <fa686aa40912102309y3b0882ddn90bb95c8ab0ae62d@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1260413279.306784.161998452424.1.gpush@pororo>
In-Reply-To: <1260413279.306784.161998452424.1.gpush@pororo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeremy Kerr <jeremy.kerr@canonical.com>
Cc: devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, linuxppc-dev@lists.ozlabs.org

On Wed, Dec 9, 2009 at 7:47 PM, Jeremy Kerr <jeremy.kerr@canonical.com> wrote:
> Merge common function between powerpc, sparc and microblaze. Code is
> identical for powerpc and microblaze, but adds a lock (and release) of
> the devtree_lock on sparc.
>
> Currently untested.
>
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

Added to my test branch.  We'll see how it shakes out.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
