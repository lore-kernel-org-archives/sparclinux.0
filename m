From: tndave <tushar.n.dave@oracle.com>
Date: Fri, 25 Nov 2016 20:23:04 +0000
Subject: Re: [PATCH v3] dbri: Fix compiler warning
Message-Id: <9d1c84e8-253d-c78b-db5f-6aa37f098d37@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1480019716-14225-1-git-send-email-tushar.n.dave@oracle.com>
 <s5ha8cn9a9j.wl-tiwai@suse.de>
 <20161125.115447.967164976172058750.davem@davemloft.net>
In-Reply-To: <20161125.115447.967164976172058750.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Miller <davem@davemloft.net>, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, thomas.tai@oracle.com, perex@perex.cz, sparclinux@vger.kernel.org



On 11/25/2016 08:54 AM, David Miller wrote:
> From: Takashi Iwai <tiwai@suse.de>
> Date: Fri, 25 Nov 2016 10:30:48 +0100
>
>> On Thu, 24 Nov 2016 21:35:16 +0100,
>> Tushar Dave wrote:
>>>
>>> dbri uses 'u32' for dma handle while invoking kernel DMA APIs,
>>> instead of using dma_addr_t. This hasn't caused any 'incompatible
>>> pointer type' warning on SPARC because until now dma_addr_t is of
>>> type u32. However, recent changes in SPARC ATU (iommu) enabled 64bit
>>> DMA and therefore dma_addr_t became of type u64. This makes
>>> 'incompatible pointer type' warnings inevitable.
>>>
>>> e.g.
>>> sound/sparc/dbri.c: In function =A1snd_dbri_create=A2:
>>> sound/sparc/dbri.c:2538: warning: passing argument 3 of =A1dma_zalloc_c=
oherent=A2 from incompatible pointer type
>>> ./include/linux/dma-mapping.h:608: note: expected =A1dma_addr_t *=A2 bu=
t argument is of type =A1u32 *=A2
>>>
>>> For the record, dbri(sbus) driver never executes on sun4v. Therefore
>>> even though 64bit DMA is enabled on SPARC, dbri continues to use
>>> legacy iommu that guarantees DMA address is always in 32bit range.
>>>
>>> This patch resolves above compiler warning.
>>>
>>> Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>
>>> Reviewed-by: thomas tai <thomas.tai@oracle.com>
>>> ---
>>> v2->v3:
>>> - Use %pad to print dma_addr_t. Comment by Takashi Iwai.
>>
>> Applied now.  Thanks!
>
> This patch is absolutely not appropriate for your tree Takashi.
>
> It's for the sparc tree because that's where the dma_addr_t
> type was changed from 32-bit to 64-bit on sparc64, which is
> what caused this build warning.
>
> Dave, please only send sparc specific driver patches to
> sparclinux@vger.kernel.org in the future so we can avoid
> this kind of problem.  The whole handling of the dma_addr_t
> type change on sparc64 has been a real mess, quite honestly.
I got your point. I will keep it in mind in future submission.

Thanks.

-Tushar

>
