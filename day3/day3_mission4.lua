-- Title: Security Best Practices
-- Description: Important tips to secure AO smart contracts.

-- 1. Validate inputs and message data:
Handlers.add(  
    "validated-handler",  
    function(msg)  
        assert(msg.Tags.role == "admin", "Admin privilege required")  
        -- Proceed with action  
    end  
)  

-- 2. Use Owner (or other auth mechanisms) for restricted actions:
if not State.AdminList then  
    State.AdminList = { [Owner] = true }  -- Initialize admin list  
end  

-- 3. Principle of least privilege:
Handlers.add(  
    "secure-messaging",  
    Handlers.utils.hasMatchingData("secure-cmd"),  
    function(msg)  
        ao.send({ Target = "<OTHER_PROCESS>", Data = "validated-request" })  
    end  
)  

-- 4. Use ao.send (in contract code) vs Send:
--    In handlers, prefer ao.send because it returns the message object (helpful for logging or debugging ([FAQ | Cookbook](https://cookbook_ao.g8way.io/guides/aos/faq.html#:~:text=Send%20vs%20ao))】.
--    The `Send` function is a convenience in the CLI; `ao.send` is better in scripts.
-- OK

-- 5. Test thoroughly:
--    Use various scenarios to ensure your contract handles unexpected or malicious inputs gracefully (no crashes, proper error messages).
-- Following these practices will make your contracts more robust and secure on the AO network.
-- OK