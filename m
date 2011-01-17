From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Mon, 17 Jan 2011 17:02:34 +0000
Subject: Re: silo fails to build with e2fsprogs-1.41.14 (undefined references
Message-Id: <4D34762A.8080600@oldelvet.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <4D2B59AC.8040203@gentoo.org>
In-Reply-To: <4D2B59AC.8040203@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org



On 17/01/2011 13:22, Alex Buell wrote:
> On Sun, 2011-01-16 at 19:59 -0800, David Miller wrote:
>> From: Alex Buell<alex.buell@munted.org.uk>
>> Date: Sat, 15 Jan 2011 12:57:09 +0000
>>
>>> On Sat, 2011-01-15 at 13:07 +0100, Ra=C3=BAl Porcel wrote:
>>>> Thanks, it builds, but silo fails to work:
>>>>
>>>> Boot device: disk1  File and args:
>>>> SILO Version 1.4.14_git2010228_p1
>>>>
>>>> Unknown ext2 error: 4294967295
>>>>
>>>> Fatal error: Unable to open filesystem
>>>>
>>>> Couldn't load /etc/silo.conf
>>>> No config file loaded, you can boot just from this command line
>>>> Type [prompath;]part/path_to_image [parameters] on the prompt
>>>> E.g. /iommu/sbus/espdma/esp/sd@3,0;4/vmlinux root=3D/dev/sda4
>>>> or 2/vmlinux.live (to load vmlinux.live from 2nd partition of boot dis=
k)
>>>> boot:
>>>
>>> This problem exists with all versions of silo linked against
>>> e2fsprogs-1.41.14.
>>
>> Can you guys please test this patch out?  It's against the current
>> tree.
>>
>> Thanks!
>>
>> --------------------
>> malloc: Provide posix_memalign() implementation.
>>
>> ext2progs library really wants a working version of this,
>> and thankfully it's not that hard to do.
>>
>> Signed-off-by: David S. Miller<davem@davemloft.net>
>>
>> diff --git a/common/malloc.c b/common/malloc.c
>> index cc3946d..d05061b 100644
>> --- a/common/malloc.c
>> +++ b/common/malloc.c
>> @@ -27,6 +27,12 @@ static char *malloc_ptr =3D (char *) MALLOC_BASE;
>>
>>   static char *last_alloc =3D 0;
>>
>> +static char *align_ptr_to(char *ptr, unsigned long align)
>> +{
>> +    return (char *) ((((unsigned long) ptr) + (align - 1UL))&
>> +		     ~(align - 1UL));
>> +}
>> +
>>   void *malloc (int size)
>>   {
>>       char *caddr;
>> @@ -34,10 +40,34 @@ void *malloc (int size)
>>       caddr =3D malloc_ptr;
>>       malloc_ptr +=3D size;
>>       last_alloc =3D caddr;
>> -    malloc_ptr =3D (char *) ((((unsigned long) malloc_ptr) + 7)&  (~7));
>> +    malloc_ptr =3D align_ptr_to(malloc_ptr, 7UL);
I think that should be 8UL because align_ptr_to does -1 to make it 7.

>>       return caddr;
>>   }
>>
>> +int posix_memalign(void **memptr, unsigned long alignment, unsigned lon=
g size)
>> +{
>> +    char *caddr;
>> +
>> +    if (alignment&  (alignment - 1UL))
>> +        return -1;
>> +    if (alignment&  (sizeof(void *) - 1UL))
>> +        return -1;
>> +
>> +    if (size =3D 0) {
>> +      *memptr =3D (void *) 0;
>> +      return 0;
>> +    }
>> +
>> +    caddr =3D align_ptr_to(malloc_ptr, alignment);
>> +    malloc_ptr =3D (caddr + size);
>> +    last_alloc =3D caddr;
>> +    malloc_ptr =3D align_ptr_to(malloc_ptr, 7UL);
Ditto

Regards

Richard

>> +
>> +    *memptr =3D caddr;
>> +
>> +    return 0;
>> +}
>> +
>>   void free (void *m)
>>   {
>>       if (m =3D last_alloc)
>> diff --git a/second/fs/ext2.c b/second/fs/ext2.c
>> index 12d00dc..57f5e9a 100644
>> --- a/second/fs/ext2.c
>> +++ b/second/fs/ext2.c
>> @@ -163,9 +163,3 @@ void *realloc(void *p, int size)
>>   {
>>           return NULL;
>>   }
>> -
>> -int posix_memalign(void **memptr, size_t alignment, size_t size)
>> -{
>> -	*memptr =3D NULL;
>> -	return -1;
>> -}
>
> With that patch, I now get a different error:
>
> SILO Version 1.4.14
> 	ERROR: Last trap: Memory Address not aligned
>
> Error -256
> {0] OK
>
> (Now I've got to boot off my rescue CD and rebuild SILO)
>
> Is anyone else getting the same error?
