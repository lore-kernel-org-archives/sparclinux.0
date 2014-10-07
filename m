From: Kjetil Oftedal <oftedal@gmail.com>
Date: Tue, 07 Oct 2014 18:38:57 +0000
Subject: Re: [PATCH] sparc64: use COMMAND_LINE_SIZE for boot string
Message-Id: <CALMQjD8xcyoGuSZdT6jNFGM_oHpgNd3p4y5JtAzZohrpGmD3qg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <5432BE03.10405@oracle.com>
In-Reply-To: <5432BE03.10405@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 07/10/2014, Dave Kleikamp <dave.kleikamp@oracle.com> wrote:
> Even though I just sent a new patch...
>
> On 10/06/2014 11:23 PM, David Miller wrote:
>> From: Dave Kleikamp <dave.kleikamp@oracle.com>
>> Date: Mon, 06 Oct 2014 11:06:27 -0500
>>
>>> sparc64 defines COMMAND_LINE_SIZE to be 2048, but the boot string is
>>> hard-coded to be 256 bytes long.
>>>
>>> based on a patch by Bob Picco
>>>
>>> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
>>
>> I think we might be limited by the size of barg_out[] in the SILO
>> bootloader, which is 1024 bytes.
>>
>> SILO massages the command line into barg_out[] then does:
>>
>> 		if (architecture = sun4u)
>> 		    kernel_params = (char *)((hdrs->bootstr_info_ptr_low - 0x400000) +
>> 				(image_base - 0x4000));
>>  ...
>> 	if (kernel_params) {
>>     	    extern char barg_out[];
>>     	    int len = *(unsigned int *)kernel_params;
>>
>>     	    strncpy (kernel_params + 8, barg_out, len);
>>     	    kernel_params [8 + len - 1] = 0;
>>     	    *(unsigned int *)(kernel_params + 4) = 1;
>> 	}
>>
>> So it blindly copies however many bytes you tell it to in that
>> bootstr_info area :-/
>
> strncpy will still stop at the first null character, so the only way it
> will copy more than 1024 bytes would be if it has already overflowed
> barg_out in constructing the command line. Writing the final null
> terminator into kernel_params is not a problem.
>

Just a note from the strncpy manpage:
"If  the  length of src is less than n, strncpy() writes additional null
 bytes to dest to ensure that a total of n bytes are written."

So strncpy always writes len bytes, regardless of the presence of a null char.
(Unless silo strncpy is different ?)
