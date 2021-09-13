Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F752C433EF
	for <sparclinux@archiver.kernel.org>; Mon, 13 Sep 2021 18:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6129E60F24
	for <sparclinux@archiver.kernel.org>; Mon, 13 Sep 2021 18:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240262AbhIMSyM (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 13 Sep 2021 14:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbhIMSyM (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 13 Sep 2021 14:54:12 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165C8C061574;
        Mon, 13 Sep 2021 11:52:56 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso14740427ota.8;
        Mon, 13 Sep 2021 11:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4AWox8sawkC9CtK9PuNlbDARnSgX50OifQb05G9AldE=;
        b=Nu1zivWJv1dHLWchmUewcCSBHoNemQBRH+ir0M38rNLxuz/7OFJQEUAgXurtWxorEA
         F3tVwn1PEIfNUnV9/SFuLl0/8qzOhaZoAzf1GMzPqVHfGcFjkaX/OV6Kbg3y3uYr/KqP
         I56nGA4rUvcQUaOBYKB7alAWmwddRjocOeD46sdEMO2t5/+737oFgqOaCytdcgTIfSrm
         yZWu76uUIuXTYrq5SbyNWw8GGx4a3Y4Kb4Q3rUqH7NnKaB3Kop8nhjab3SYADsV6G6dI
         2CjwdE+xEGtF8JDks4aFoF/p8eJUVCqIzgfkQHI7j3l24RAefK9W9UEvZZ3R7LM3sFvK
         IxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4AWox8sawkC9CtK9PuNlbDARnSgX50OifQb05G9AldE=;
        b=Z9HM93TlvfY2SJaDK64t6pProOzstufVCFlXC3g1mxamZVWPk3I++PamNJuH0addNN
         28/y1FGTcapQz+aokDi8AZmfC6FTVP7pZsRHj/45uATW3TYCkVGpsrHYBXnPY1dcjEFF
         H2nziab1P2HXIdJARldC1LrF62+U8KvTfKyCh44yz4FgYLtGbYnjlwGyWH6VQVH0ZLdb
         Qrx210ZqTr/SNE3y5gn7PBBrqEwVNpTc3J+aMSUeTdjt3l5zD7cWNvHFzKq4b+S5LJeM
         OCfxDL+W4uuLsKsAeY28YWE1t7Fexr9ETTuR8L5jJjmWEjumhgcyYN94v5TfL8T6oIXJ
         XNxA==
X-Gm-Message-State: AOAM531ILiNdkEwf8YxBkbw8utaYHAa6JLQhbRVi8euFDUVXZS7a9C6z
        VjeIr+0ObKXccjInt9+JzzikvQv7H98=
X-Google-Smtp-Source: ABdhPJwc1irISiXfMAMk7sZTIefRY4TWJVl/lNOiWAxB71vhgxtzKHwpI4e2TQRIfRm0oocKk+X36w==
X-Received: by 2002:a9d:721b:: with SMTP id u27mr11410487otj.214.1631559175413;
        Mon, 13 Sep 2021 11:52:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b24sm1902102oic.33.2021.09.13.11.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 11:52:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@kernel.org>
References: <20210913163712.922188-1-linux@roeck-us.net>
 <YT+SPIAl0IdWOAn/@ravnborg.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] sparc: mdesc: Fix compile error seen with gcc 11.x
Message-ID: <d0a4b46a-2f0e-f6a2-1342-777e738d9525@roeck-us.net>
Date:   Mon, 13 Sep 2021 11:52:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YT+SPIAl0IdWOAn/@ravnborg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 9/13/21 11:02 AM, Sam Ravnborg wrote:
> Hi Guenter,
> 
> On Mon, Sep 13, 2021 at 09:37:12AM -0700, Guenter Roeck wrote:
>> sparc64 images fail to compile with gcc 11.x, reporting the following
>> errors.
>>
>> arch/sparc/kernel/mdesc.c:647:22: error:
>> 	'strcmp' reading 1 or more bytes from a region of size 0
>> arch/sparc/kernel/mdesc.c:692:22: error:
>> 	'strcmp' reading 1 or more bytes from a region of size 0
>> arch/sparc/kernel/mdesc.c:719:21:
>> 	error: 'strcmp' reading 1 or more bytes from a region of size 0
>>
>> The underlying problem is that node_block() returns a pointer beyond
>> the end of struct mdesc_hdr. gcc 11.x detects that and reports the error.
>> Adding an additional zero-length field to struct mdesc_hdr and pointing
>> to that field fixes the problem.
>>
>> Cc: Arnd Bergmann <arnd@kernel.org>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> My apologies if a similar patch was submitted already; I was unable to find it.
>> I did find the following patch:
>>      https://git.busybox.net/buildroot/commit/?id=6e1106b4a9aee25d1556310d5cd1cb6dde2e6e3f
>> but I failed to find it in patchwork or on lore.kernel.org, and it
>> seems to be more expensive than the solution suggested here.
>>
>>   arch/sparc/kernel/mdesc.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
>> index 8e645ddac58e..c67bdcc23727 100644
>> --- a/arch/sparc/kernel/mdesc.c
>> +++ b/arch/sparc/kernel/mdesc.c
>> @@ -39,6 +39,7 @@ struct mdesc_hdr {
>>   	u32	node_sz; /* node block size */
>>   	u32	name_sz; /* name block size */
>>   	u32	data_sz; /* data block size */
>> +	char	data[0];
>>   } __attribute__((aligned(16)));
> 
> I do not think this will works.
> See following comment:
>   * mdesc_hdr and mdesc_elem describe the layout of the data structure
>   * we get from the Hypervisor.
> 
> With the above change you increased the size from 16 to 32 bytes,
> and any code using sizeof(struct mdesc_hdr) will now point too far in
> memory for the second and subsequent entries.
> 
> I did not take any closer look, but this was from a quick analysis.
> 

Sorry, I didn't realize that a field of size 0 increases the structure size
on sparc. I had checked the size of the old and the new structure with gcc
on x86_64 and didn't see a field size increase.

Guenter

---
Test code I had used:

#include <stddef.h>
#include <stdio.h>

typedef unsigned int u32;

struct mdesc_hdr {
         u32     version; /* Transport version */
         u32     node_sz; /* node block size */
         u32     name_sz; /* name block size */
         u32     data_sz; /* data block size */
} __attribute__((aligned(16)));

struct mdesc_hdr2 {
         u32     version; /* Transport version */
         u32     node_sz; /* node block size */
         u32     name_sz; /* name block size */
         u32     data_sz; /* data block size */
         char    data[0];
} __attribute__((aligned(16)));

int main()
{
	printf("%ld %ld\n", sizeof(struct mdesc_hdr), sizeof(struct mdesc_hdr2));

	return 0;
}
