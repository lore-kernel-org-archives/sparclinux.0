From: Konrad Eisele <konrad@gaisler.com>
Date: Thu, 11 Jun 2009 06:44:35 +0000
Subject: Re: [PATCH 3/7] Introduce the sparc-leon CPU type. Add sparc_leon
Message-Id: <4A30A7D3.8000406@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4A2E45DC.8050802@gaisler.com>
In-Reply-To: <4A2E45DC.8050802@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Julian Calaby wrote:
> On Wed, Jun 10, 2009 at 20:13, <konrad@gaisler.com> wrote:
>> From: Konrad Eisele <konrad@gaisler.com>
>>
>>> We have two leon.c (+leon.o), this is confusing.
>>> Consider a better naming scheme.
>>>
>>> leon_mm.c, leon_kernel.c for example.
>> Changed to leon_m.c and leon_k.c
> 
> leon_m.c and leon_k.c are significantly better than the original
> names, however the reason that leon_mm.c and leon_kernel.c were
> suggested is that one can, at a glance, look at the file name and know
> what's going on in the file.
> 
> Not that these new names are bad, but if you re-spin these patches
> again, you might want to consider changing them.
> 
> Thanks,
> 

Ok, I can do this. I thought the smaller the better.
-- Konrad


