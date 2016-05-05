From: Tadeusz Struk <tadeusz.struk@intel.com>
Date: Thu, 05 May 2016 16:09:10 +0000
Subject: Re: [crypto / sparc64] cryptomgr_test OOPS
Message-Id: <909d04e6-03a7-462a-8a3f-d110bf98a865@intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20160503.123301.298039059390449291.davem@davemloft.net>
 <20160504040731.GA25758@gondor.apana.org.au>
 <CADxRZqws2yAMSqeMDYb6w6OUXJMMbv9wMaY7Zc6YX+szk2vO3g@mail.gmail.com>
 <20160505084249.GA4971@gondor.apana.org.au>
 <CADxRZqwxB-+DTV-qKFK6CVXwVV0h9yDkH6GxcjmA-M9KY2HM7g@mail.gmail.com>
 <efc65239-4d7f-8d32-8928-0ac1bd8e46f3@intel.com>
 <CADxRZqzyZgG=e-6aPcHrEopq51nqoU0NqdMnRcCUWkw39XB56A@mail.gmail.com>
In-Reply-To: <CADxRZqzyZgG=e-6aPcHrEopq51nqoU0NqdMnRcCUWkw39XB56A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anatoly Pugachev <matorola@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, David Miller <davem@davemloft.net>, linux-crypto@vger.kernel.org, sparclinux@vger.kernel.org, Nicolai Stange <nicstange@gmail.com>

On 05/05/2016 08:31 AM, Anatoly Pugachev wrote:
> On Thu, May 5, 2016 at 6:00 PM, Tadeusz Struk <tadeusz.struk@intel.com> wrote:
>> On 05/05/2016 02:40 AM, Anatoly Pugachev wrote:
>>> sure, based on your cryptodev git, just tried 4.3 (6a13feb , good)
>>> kernel in attempt to find (bisect) when RSA code break, already tested
>>> 4.5 (44d1b6d , bad) , 4.4 (afd2ff9 , bad).
>>> Going to try your patch soon (when I'm back home).
>>> So far 4.3 passes RSA stage without OOPS, but for other reason does
>>> not boot to login prompt. Boot log exempt (4.3), this is with
>>> CONFIG_CRYPTO_RSA=y :
>>
>> Anatoly, could you also give this a try please:
>> Thanks
>>
>> diff --git a/crypto/testmgr.c b/crypto/testmgr.c
>> index b86883a..770970ff 100644
>> --- a/crypto/testmgr.c
>> +++ b/crypto/testmgr.c
>> @@ -1805,8 +1805,8 @@ static int do_test_rsa(struct crypto_akcipher *tfm,
>>                 goto free_req;
>>
>>         sg_init_table(src_tab, 2);
>> -       sg_set_buf(&src_tab[0], vecs->m, 8);
>> -       sg_set_buf(&src_tab[1], vecs->m + 8, vecs->m_size - 8);
>> +       sg_set_buf(&src_tab[0], vecs->m, 4);
>> +       sg_set_buf(&src_tab[1], vecs->m + 4, vecs->m_size - 4);
>>         sg_init_one(&dst, outbuf_enc, out_len_max);
>>         akcipher_request_set_crypt(req, src_tab, &dst, vecs->m_size,
>>                                    out_len_max);
> 
> 
> Tadeusz,
> 
> do you still want to test it , after I have reported that Herbert patch works?
> 

Hi Anatoly,
Since Herbert's patch fixes it for you here is no need to test this one.
Thanks,
-- 
TS
