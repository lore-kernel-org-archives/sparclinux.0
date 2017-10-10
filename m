From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 10 Oct 2017 17:19:19 +0000
Subject: Re: [PATCH v11 0/9] complete deferred page initialization
Message-Id: <bd333387-fefc-c48a-2258-1d8c36f2db41@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20171009221931.1481-1-pasha.tatashin@oracle.com>
 <20171010141547.zpdptsccsblyw634@dhcp22.suse.cz>
In-Reply-To: <20171010141547.zpdptsccsblyw634@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

I wanted to thank you Michal for spending time and doing the in-depth 
reviews of every incremental change. Overall the series is in much 
better shape now because of your feedback.

Pavel

On 10/10/2017 10:15 AM, Michal Hocko wrote:
> Btw. thanks for your persistance and willingness to go over all the
> suggestions which might not have been consistent btween different
> versions. I believe this is a general improvement in the early
> initialization code. We do not rely on an implicit zeroing which just
> happens to work by a chance. The perfomance improvements are a bonus on
> top.
> 
> Thanks, good work!
> 
