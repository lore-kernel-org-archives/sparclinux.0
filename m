From: Michal Hocko <mhocko@kernel.org>
Date: Tue, 15 Aug 2017 09:36:32 +0000
Subject: Re: [v6 15/15] mm: debug for raw alloctor
Message-Id: <20170815093631.GD29067@dhcp22.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-16-git-send-email-pasha.tatashin@oracle.com>
 <20170811130831.GN30811@dhcp22.suse.cz>
 <87d84cad-f03a-88f0-7828-6d3bf7ac473c@oracle.com>
 <20170814115000.GJ19063@dhcp22.suse.cz>
 <b4eb28ad-2d58-fb23-2139-427df46c2773@oracle.com>
In-Reply-To: <b4eb28ad-2d58-fb23-2139-427df46c2773@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon 14-08-17 10:01:52, Pasha Tatashin wrote:
> >>However, now thinking about it, I will change it to CONFIG_MEMBLOCK_DEBUG,
> >>and let users decide what other debugging configs need to be enabled, as
> >>this is also OK.
> >
> >Actually the more I think about it the more I am convinced that a kernel
> >boot parameter would be better because it doesn't need the kernel to be
> >recompiled and it is a single branch in not so hot path.
> 
> The main reason I do not like kernel parameter is that automated test suits
> for every platform would need to be updated to include this new parameter in
> order to test it.

How does this differ from the enabling a config option and building a
separate kernel?

My primary point of the kernel option was to have something available to
debug without recompiling the kernel which is more tedious than simply
adding one option to the kernel command line.
-- 
Michal Hocko
SUSE Labs
