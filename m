From: Bob Picco <bpicco@meloft.net>
Date: Wed, 18 Sep 2013 21:59:59 +0000
Subject: Re: [PATCH 0/4] sparc64 page table
Message-Id: <20130918215959.GA29427@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <1379339199-9388-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1379339199-9388-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,
David Miller wrote:	[Wed Sep 18 2013, 12:28:09PM EDT]
> From: Bob Picco <bpicco@meloft.net>
> Date: Mon, 16 Sep 2013 09:46:35 -0400
> 
> > There is a configuration choice between the four level page table scheme
> > and the current three level page table scheme. It is our hope that the
> > exisiting three level scheme has been left unchanged functionally. This
> > can be viewed like sparc64 THP which impacted the existing three level page
> > table scheme and is configuration selectable.
> 
> So again this is unacceptable.
I understand.
> 
> Even worse, the 4-level page table setting creates a kernel that absolutely
> does not work on older chips.
> 
> The problem is the PAGE_OFFSET selections.  You can't use a
> PAGE_OFFSET value that tries to use parts of the virtual address space
> which is not supported on UltraSPARC-I et al.
This I'm aware of. Otherwise why would it remain where it is at for S3 core.
> 
> So, in particular, PAGE_OFFSET will need to be determined dynamically
> at run time.  Yes, this means looking at the appropriate cpu
> properties to see how much virtual address space is supported, and
> then code patching the appropriate assembler instructions.  We already
> have good support for the latter.
Above I didn't consider because of the config option.

To Summarize:
	1) Dynamically patch PAGE_OFFSET.
	2) Remain at three level page table.
. So effectively remain at a single binary for sparc64 without the aid of
a config option. Do I have this correct? 

thanx,

bob
