From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 03 Mar 2015 22:29:16 +0000
Subject: Re: [PATCH 1/2] Break up monolithic iommu table/lock into finer graularity pools and lock
Message-Id: <CAGRGNgVcQ5VSop9HGuFPgc_td+MPoOZ=oqTiWGTrb3rW4SA+8Q@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20141222224321.GI29674@oracle.com>
In-Reply-To: <20141222224321.GI29674@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Sowmini,

On Wed, Mar 4, 2015 at 1:33 AM, Sowmini Varadhan
<sowmini.varadhan@oracle.com> wrote:
>> Please rewrite this so that only the truly generic stuff, which is
>> %100 agnostic to IOMMU design or architecutre, goes into the new
>> "generic" code.
>
> I just remembered that I forgot to note the changes since V1 in
> each patch of the V2 version of the set that I just sent out,
> though I have a detailed description in the cover letter.
>
> Sorry about that. I can send out v3, if a description of the
> per-patch deltas are needed.

You might want to re-read David's email, I think you're missing the point here.

The issue isn't the lack of change descriptions, the issue is that
you've added lots of Sparc specific stuff to the generic
implementation.

You might want to re-read your changes with that in mind and either
justify or change things appropriately. (By justify, I mean point out
that some other arch needs whatever facility too)

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
