From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 14 Aug 2017 13:35:16 +0000
Subject: Re: [v6 04/15] mm: discard memblock data later
Message-Id: <3c223cac-68f8-f810-38dd-4ff580048e63@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-5-git-send-email-pasha.tatashin@oracle.com>
 <20170811093249.GE30811@dhcp22.suse.cz>
 <6366171f-1a30-2faa-d776-01983fcb5a00@oracle.com>
 <20170811160436.GS30811@dhcp22.suse.cz>
 <a63eb223-455f-ae57-122f-7b2655e3de26@oracle.com>
 <20170814113652.GF19063@dhcp22.suse.cz>
In-Reply-To: <20170814113652.GF19063@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

>> OK, I will post it separately. No it does not depend on the rest, but the
>> reset depends on this. So, I am not sure how to enforce that this comes
>> before the rest.
> 
> Andrew will take care of that. Just make it explicit that some of the
> patch depends on an earlier work when reposting.

Ok.

>> Yes, they said that the problem was bisected down to this patch. Do you know
>> if there is a way to submit a patch to this test robot?
> 
> You can ask them for re testing with an updated patch by replying to
> their report. ANyway I fail to see how the change could lead to this
> patch.

I have already done that. Anyway, I think it is unrelated. I have used 
their scripts to test the patch alone, with number of elements in 
memblock array reduced down to 4. Verified that my freeing code is 
called, and never hit the problem that they reported.
