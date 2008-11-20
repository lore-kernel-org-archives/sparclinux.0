From: "k e" <eiselekd@gmail.com>
Date: Thu, 20 Nov 2008 12:05:54 +0000
Subject: Re: Extending Leon-Sparc page table size to 32k
Message-Id: <e8611b790811200405p57a3c619hb8f1c5271cf01633@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <e8611b790811181236q5c36993dq1da2d43888c5c7b2@mail.gmail.com>
In-Reply-To: <e8611b790811181236q5c36993dq1da2d43888c5c7b2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Nov 20, 2008 at 11:00 AM, David Miller <davem@davemloft.net> wrote:
> From: "k e" <eiselekd@gmail.com>
> Date: Tue, 18 Nov 2008 21:36:24 +0100
>
>> So I could at max form a 8*64Q2 entry software PTE-table that would
>> only be 2k.
>> However the page size would be 32k anyway.
>
> So you would be able to have (32 / 2) PTE tables in one page.
> I don't see what the problem is with that.

If I use the bit index layout similar to SRMMU's [31-24][23-18][17-12] I
would use for 32k pages: [31-24][23-18][17-15]. Therefore I would have a
8 entry PTE (32 bytes). That means I would have 1024 PTE's in one 32k page.
So I'd wonder:
- In my case pgtable.h's PTRS_PER_PTE would be 8*1024.  Therefore
  I could at max use SRMMU_PTRS_PER_PMD to 1 and PTRS_PER_PTE to 512 (64*8).
  meaning that I would loose 15/16 of the 32k page.

  _Do you think there would be a problem with unused space in the allocated
    page. Does the kernel rely on that the whole page is filled?_

  I think the whole problem is that with a 15 bit (32k) pagesize you
need at least
  15-2=13 bits combined PMD and PTE bits to get a to SRMMU_PTRS_PER_PMD =1
  to fill the whole page.

- Another possibility is that I modify the index layout to
[31-28][27-21][20-15].
  In this case I would have 13 bit combined PMD and PTE bits.
  I would have 16 entry PGD, 128 entry PMD and 64 entry PTE.
  Here I could have SRMMU_PTRS_PER_PMD = 1 with at the
  same time PTRS_PER_PTE = 8*1024 (128*64). In this case I
  could fill the whole page.

  _Do you think that a 16 entry PGD is a problem?_

-- Greetings Konrad
