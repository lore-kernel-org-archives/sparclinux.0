From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Wed, 04 Oct 2017 12:26:57 +0000
Subject: Re: [PATCH v9 06/12] mm: zero struct pages during initialization
Message-Id: <2fd7b718-c254-612b-e100-a457094e7c38@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170920201714.19817-1-pasha.tatashin@oracle.com>
 <20170920201714.19817-7-pasha.tatashin@oracle.com>
 <20171003130857.vohli6lnqj4tdmhl@dhcp22.suse.cz>
 <73ea1215-7aa2-39e1-b820-30f58119183e@oracle.com>
 <20171004084554.fhxpmywtovs5umnm@dhcp22.suse.cz>
In-Reply-To: <20171004084554.fhxpmywtovs5umnm@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 10/04/2017 04:45 AM, Michal Hocko wrote:
> On Tue 03-10-17 11:22:35, Pasha Tatashin wrote:
>>
>>
>> On 10/03/2017 09:08 AM, Michal Hocko wrote:
>>> On Wed 20-09-17 16:17:08, Pavel Tatashin wrote:
>>>> Add struct page zeroing as a part of initialization of other fields in
>>>> __init_single_page().
>>>>
>>>> This single thread performance collected on: Intel(R) Xeon(R) CPU E7-8895
>>>> v3 @ 2.60GHz with 1T of memory (268400646 pages in 8 nodes):
>>>>
>>>>                           BASE            FIX
>>>> sparse_init     11.244671836s   0.007199623s
>>>> zone_sizes_init  4.879775891s   8.355182299s
>>>>                     --------------------------
>>>> Total           16.124447727s   8.362381922s
>>>
>>> Hmm, this is confusing. This assumes that sparse_init doesn't zero pages
>>> anymore, right? So these number depend on the last patch in the series?
>>
>> Correct, without the last patch sparse_init time won't change.
> 
> THen this is just misleading.
> 

OK, I will re-arrange patches the way you suggested earlier.

Pasha
