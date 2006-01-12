From: Jurij Smakov <jurij@wooyd.org>
Date: Thu, 12 Jan 2006 08:16:09 +0000
Subject: Re: strace broken on SPARC64
Message-Id: <Pine.LNX.4.63.0601120016011.4439@bobcat>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="-1463804416-139331997-1137053761=:4439"
List-Id: <sparclinux.vger.kernel.org>
References: <1136767843.9208.15.camel@duncow>
In-Reply-To: <1136767843.9208.15.camel@duncow>
To: sparclinux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463804416-139331997-1137053761=:4439
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

On Thu, 12 Jan 2006, Jurij Smakov wrote:
>
> Hi,
>
> I can confirm that this patch (after rediffing) fixes strace problems and 
> does not seem to introduce any negative side effects. Actual patch which I've 
> used for testing (applied to 2.6.15) is attached.

... and, of course, I attached the wrong patch :-P. The one attached to 
this message is correct, md5sum is d8475d31bfe23c927e6d2348fa634ea6.

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
---1463804416-139331997-1137053761=:4439
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=strace.patch
Content-Transfer-Encoding: BASE64
Content-Description: 
Content-Disposition: attachment; filename=strace.patch

LS0tIGEvYXJjaC9zcGFyYzY0L2tlcm5lbC9lbnRyeS5TCTIwMDYtMDEtMDIg
MTk6MjE6MTAuMDAwMDAwMDAwIC0wODAwDQorKysgYi9hcmNoL3NwYXJjNjQv
a2VybmVsL2VudHJ5LlMJMjAwNi0wMS0xMSAyMTo1Njo1Mi4wMDAwMDAwMDAg
LTA4MDANCkBAIC0xNjU3LDEzICsxNjU3LDEwIEBADQogCS8qIENoZWNrIGlm
IGZvcmNlX3N1Y2Nlc3NmdWxfc3lzY2FsbF9yZXR1cm4oKQ0KIAkgKiB3YXMg
aW52b2tlZC4NCiAJICovDQotCWxkdWIJCVslY3VycHRyICsgVElfU1lTX05P
RVJST1JdLCAlbDANCi0JYnJ6LHB0CQklbDAsIDFmDQotCSBub3ANCi0JYmEs
cHQJCSV4Y2MsIDgwZg0KKwlsZHViCQlbJWN1cnB0ciArIFRJX1NZU19OT0VS
Uk9SXSwgJWwyDQorCWJybnosYSxwbgklbDIsIDgwZg0KIAkgc3RiCQklZzAs
IFslY3VycHRyICsgVElfU1lTX05PRVJST1JdDQogDQotMToNCiAJY21wCQkl
bzAsIC1FUkVTVEFSVF9SRVNUQVJUQkxPQ0sNCiAJYmdldSxwbgkJJXhjYywg
MWYNCiAJIGFuZGNjCQklbDAsIChfVElGX1NZU0NBTExfVFJBQ0V8X1RJRl9T
RUNDT01QfF9USUZfU1lTQ0FMTF9BVURJVCksICVsNg0K

---1463804416-139331997-1137053761=:4439--
