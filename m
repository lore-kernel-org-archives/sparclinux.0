From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 11 Aug 2017 16:04:51 +0000
Subject: Re: [v6 09/15] sparc64: optimized struct page zeroing
Message-Id: <3830e513-cb35-e52e-341c-25eaecc51d43@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-10-git-send-email-pasha.tatashin@oracle.com>
 <20170811125326.GK30811@dhcp22.suse.cz>
In-Reply-To: <20170811125326.GK30811@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

>> Add an optimized mm_zero_struct_page(), so struct page's are zeroed without
>> calling memset(). We do eight to tent regular stores based on the size of
>> struct page. Compiler optimizes out the conditions of switch() statement.
> 
> Again, this doesn't explain why we need this. You have mentioned those
> reasons in some previous emails but be explicit here please.
> 

I will add performance data to this patch as well.

Thank you,
Pasha
